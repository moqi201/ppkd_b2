// lib/tugas_14/view/filtered_character_list_view.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/api/get_character.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart';
import 'package:ppkd_b2/tugas_14/view/character_list_detail.dart';
import 'package:ppkd_b2/tugas_14/widget/fillter_dialog_widget.dart'; // Pastikan path ini benar

typedef GetEnumValue =
    String? Function(dynamic enumValue, EnumValues enumValues);

class FilteredCharacterListView extends StatefulWidget {
  final GetEnumValue getEnumValue;
  final House? initialHouseFilter;

  const FilteredCharacterListView({
    super.key,
    required this.getEnumValue,
    this.initialHouseFilter,
  });

  @override
  State<FilteredCharacterListView> createState() =>
      _FilteredCharacterListViewState();
}

class _FilteredCharacterListViewState extends State<FilteredCharacterListView> {
  late Future<List<CharacterList>> _charactersFuture;
  List<CharacterList> _allCharacters =
      []; // Menyimpan semua karakter yang diambil dari API
  List<String> _allSpecies = [];

  FilterSelections _currentFilterSelections = {
    'house': <House>{},
    'gender': <Gender>{},
    'species': <String>{},
    'ancestry': <Ancestry>{},
    'eyeColour': <EyeColour>{},
    'hairColour': <HairColour>{},
    'patronus': <Patronus>{},
  };

  House?
  _activeHouseFilter; // Ini untuk tema AppBar dan dialog, merepresentasikan filter House tunggal yang aktif.

  // --- Fitur Search Baru ---
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  // -------------------------

  @override
  void initState() {
    super.initState();
    // Inisialisasi filter house jika initialHouseFilter diberikan saat navigasi
    if (widget.initialHouseFilter != null &&
        widget.initialHouseFilter != House.EMPTY) {
      _currentFilterSelections['house']!.add(widget.initialHouseFilter!);
      _activeHouseFilter = widget.initialHouseFilter;
    } else {
      _activeHouseFilter = null;
    }
    _loadCharacters(
      applyFilters: true,
    ); // Muat data dan langsung terapkan filter awal

    // Listener untuk controller search
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // --- Fungsi Search Baru ---
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchQuery = ""; // Clear query when closing search
      }
    });
  }
  // -------------------------

  // Fungsi untuk memuat karakter dari API
  // Parameter applyFilters: Jika true, data yang dimuat akan langsung difilter (tidak digunakan langsung di sini, tapi untuk memicu rebuild).
  // Parameter resetAllFilters: Jika true, semua filter (termasuk search) akan direset sebelum memuat data baru.
  Future<void> _loadCharacters({
    bool applyFilters = false,
    bool resetAllFilters = false,
  }) async {
    setState(() {
      if (resetAllFilters) {
        _currentFilterSelections = {
          // Reset semua filter secara eksplisit
          'house': <House>{},
          'gender': <Gender>{},
          'species': <String>{},
          'ancestry': <Ancestry>{},
          'eyeColour': <EyeColour>{},
          'hairColour': <HairColour>{},
          'patronus': <Patronus>{},
        };
        _activeHouseFilter = null; // Reset tema House
        // Juga reset search query jika mereset semua filter
        _searchController.clear();
        _searchQuery = "";
        _isSearching = false; // Tutup juga search bar
      }

      _charactersFuture =
          getCar(); // Selalu panggil API saat _loadCharacters dipanggil
    });

    try {
      final characters = await _charactersFuture;
      setState(() {
        _allCharacters = characters; // Simpan semua karakter yang baru diambil
        Set<String> uniqueSpecies =
            characters.map((char) => char.species).whereType<String>().toSet();
        _allSpecies = uniqueSpecies.toList()..sort();

        // Tidak perlu memfilter ulang di sini, FutureBuilder akan melakukannya.
      });
    } catch (error) {
      log("Error fetching characters: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load characters: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Color _getHouseColor(House house) {
    switch (house) {
      case House.GRYFFINDOR:
        return Colors.red.shade700;
      case House.SLYTHERIN:
        return Colors.green.shade700;
      case House.HUFFLEPUFF:
        return Colors.amber.shade700;
      case House.RAVENCLAW:
        return Colors.blue.shade700;
      default:
        return Colors.deepPurple;
    }
  }

  void _showFilterDialog() async {
    final returnedSelections = await showDialog<FilterSelections>(
      context: context,
      builder: (BuildContext dialogContext) {
        return FilterDialogWidget(
          initialSelections: _currentFilterSelections, // Kirim filter saat ini
          getEnumValue: widget.getEnumValue,
          allSpecies: _allSpecies,
          activeHouseFilter: _activeHouseFilter,
        );
      },
    );

    if (returnedSelections != null) {
      setState(() {
        _currentFilterSelections = returnedSelections;
        // Perbarui _activeHouseFilter berdasarkan pilihan House di dialog
        Set<House> selectedHouses =
            _currentFilterSelections['house'] as Set<House>;
        if (selectedHouses.length == 1) {
          _activeHouseFilter = selectedHouses.first;
        } else {
          _activeHouseFilter = null;
        }
        // Pastikan juga search bar ditutup jika ada filter baru diterapkan
        _isSearching = false;
        _searchController.clear();
        _searchQuery = "";
      });
    }
  }

  // Fungsi untuk memuat ulang data dengan filter yang ada (atau semua jika tidak ada filter)
  void _onRefreshPressed() {
    // Memanggil _loadCharacters tanpa resetAllFilters akan mempertahankan filter yang ada
    _loadCharacters(applyFilters: true);
  }

  String _buildFilterSummary() {
    List<String> activeFilters = [];

    _currentFilterSelections.forEach((key, selectedValues) {
      if (selectedValues.isNotEmpty) {
        String categoryName = key[0].toUpperCase() + key.substring(1);
        List<String> values =
            selectedValues.map((value) {
              if (key == 'house')
                return widget.getEnumValue(value, houseValues) ?? 'N/A';
              if (key == 'gender')
                return widget.getEnumValue(value, genderValues) ?? 'N/A';
              if (key == 'species') return value.toString();
              if (key == 'ancestry')
                return widget.getEnumValue(value, ancestryValues) ?? 'N/A';
              if (key == 'eyeColour')
                return widget.getEnumValue(value, eyeColourValues) ?? 'N/A';
              if (key == 'hairColour')
                return widget.getEnumValue(value, hairColourValues) ?? 'N/A';
              if (key == 'patronus')
                return widget.getEnumValue(value, patronusValues) ?? 'N/A';
              return value.toString();
            }).toList();
        activeFilters.add('$categoryName: ${values.join(', ')}');
      }
    });

    String filterText;
    if (activeFilters.isEmpty) {
      filterText = 'No filters applied.';
    } else {
      filterText = 'Filtered by: ${activeFilters.join('; ')}.';
    }

    if (_searchQuery.isNotEmpty) {
      filterText += '\nSearching for: "$_searchQuery"';
    }

    return filterText;
  }

  @override
  Widget build(BuildContext context) {
    Color mainAccentColor = Color(0xff27548A);

    if (_activeHouseFilter != null && _activeHouseFilter != House.EMPTY) {
      mainAccentColor = _getHouseColor(_activeHouseFilter!);
    }

    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText:
                        'Search characters by name...', // Hint text lebih spesifik
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        _searchController.clear();
                        _searchQuery = "";
                        setState(() {}); // Trigger rebuild to clear search
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
                : const Text(
                  'Hogwarts Characters',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        backgroundColor: mainAccentColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            _isSearching ? Icons.arrow_back : Icons.arrow_back,
          ), // Back or close search
          onPressed: () {
            if (_isSearching) {
              _toggleSearch();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.search_off : Icons.search,
            ), // Search on/off toggle
            onPressed: _toggleSearch,
            tooltip: _isSearching ? 'Close Search' : 'Search Characters',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefreshPressed,
            tooltip: 'Refresh Data',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            tooltip: 'Apply Filters',
          ),
        ],
      ),
      body: Container(
        color: mainAccentColor.withOpacity(0.05),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade400, width: 2.0),
                ),
              ),
              child: Text(
                _buildFilterSummary(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<CharacterList>>(
                future: _charactersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: mainAccentColor),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red.shade400,
                            size: 60,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Failed to load characters: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed:
                                () => _loadCharacters(resetAllFilters: true),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again (Reset Filters)'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainAccentColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    // Filter characters based on _currentFilterSelections AND _searchQuery
                    List<CharacterList> filteredCharacters =
                        _allCharacters.where((char) {
                          // Combined logic for existing filters
                          bool matchesExistingFilters =
                              (_currentFilterSelections['house'] as Set<House>)
                                  .isEmpty ||
                              (char.house != null &&
                                  (_currentFilterSelections['house']
                                          as Set<House>)
                                      .contains(char.house));

                          matchesExistingFilters =
                              matchesExistingFilters &&
                              ((_currentFilterSelections['gender']
                                          as Set<Gender>)
                                      .isEmpty ||
                                  (char.gender != null &&
                                      (_currentFilterSelections['gender']
                                              as Set<Gender>)
                                          .contains(char.gender)));

                          matchesExistingFilters =
                              matchesExistingFilters &&
                              ((_currentFilterSelections['species']
                                          as Set<String>)
                                      .isEmpty ||
                                  (char.species != null &&
                                      (_currentFilterSelections['species']
                                              as Set<String>)
                                          .contains(char.species)));

                          matchesExistingFilters =
                              matchesExistingFilters &&
                              ((_currentFilterSelections['ancestry']
                                          as Set<Ancestry>)
                                      .isEmpty ||
                                  (char.ancestry != null &&
                                      (_currentFilterSelections['ancestry']
                                              as Set<Ancestry>)
                                          .contains(char.ancestry)));

                          matchesExistingFilters =
                              matchesExistingFilters &&
                              ((_currentFilterSelections['eyeColour']
                                          as Set<EyeColour>)
                                      .isEmpty ||
                                  (char.eyeColour != null &&
                                      (_currentFilterSelections['eyeColour']
                                              as Set<EyeColour>)
                                          .contains(char.eyeColour)));

                          matchesExistingFilters =
                              matchesExistingFilters &&
                              ((_currentFilterSelections['hairColour']
                                          as Set<HairColour>)
                                      .isEmpty ||
                                  (char.hairColour != null &&
                                      (_currentFilterSelections['hairColour']
                                              as Set<HairColour>)
                                          .contains(char.hairColour)));

                          matchesExistingFilters =
                              matchesExistingFilters &&
                              ((_currentFilterSelections['patronus']
                                          as Set<Patronus>)
                                      .isEmpty ||
                                  (char.patronus != null &&
                                      (_currentFilterSelections['patronus']
                                              as Set<Patronus>)
                                          .contains(char.patronus)));

                          // Logic for search query - ONLY SEARCH BY NAME
                          bool matchesSearchQuery = true;
                          if (_searchQuery.isNotEmpty) {
                            final lowerCaseQuery = _searchQuery.toLowerCase();
                            matchesSearchQuery =
                                (char.name?.toLowerCase().contains(
                                      lowerCaseQuery,
                                    ) ??
                                    false);
                          }

                          return matchesExistingFilters && matchesSearchQuery;
                        }).toList();

                    if (filteredCharacters.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_off,
                              color: Colors.grey.shade400,
                              size: 60,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'No characters found matching "$_searchQuery" with current filters.'
                                  : 'No characters found matching the selected filters.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: filteredCharacters.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = filteredCharacters[index];
                        final String? characterHouseName = widget.getEnumValue(
                          user.house,
                          houseValues,
                        );
                        final Color characterHouseColor = _getHouseColor(
                          user.house ?? House.EMPTY,
                        );

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(
                              user.name ?? 'Unknown Character',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: characterHouseColor,
                              ),
                            ),
                            subtitle: Text(
                              'House: ${characterHouseName ?? 'N/A'} | Species: ${user.species ?? 'N/A'} | Gender: ${widget.getEnumValue(user.gender, genderValues) ?? 'N/A'}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: characterHouseColor.withOpacity(
                                0.2,
                              ),
                              backgroundImage:
                                  user.image != null && user.image!.isNotEmpty
                                      ? NetworkImage(user.image!)
                                      : null,
                              child:
                                  user.image == null || user.image!.isEmpty
                                      ? Icon(
                                        Icons.person,
                                        size: 30,
                                        color: characterHouseColor,
                                      )
                                      : null,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: characterHouseColor,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => CharacterDetailScreen(
                                        character: user,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('An unexpected error occurred.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
