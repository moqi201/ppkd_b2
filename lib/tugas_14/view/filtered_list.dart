// lib/tugas_14/view/filtered_character_list_view.dart (atau home_screen.dart sesuai path Anda)
import 'dart:developer'; // Untuk log

import 'package:flutter/material.dart'; // Core Flutter UI
import 'package:ppkd_b2/tugas_14/api/get_character.dart'; // Untuk memanggil API
import 'package:ppkd_b2/tugas_14/model/character_model.dart'; // Definisi model CharacterList, EnumValues, dll.
import 'package:ppkd_b2/tugas_14/view/character_list_detail.dart'; // Layar detail karakter
// import 'package:ppkd_b2/tugas_14/widget/fillter_dialog_widget.dart'; // Dialog filter akan dihapus, jadi impor ini juga dihapus

// Typedef untuk fungsi helper yang mengonversi enum ke String
typedef GetEnumValue =
    String? Function(dynamic enumValue, EnumValues enumValues);

class FilteredCharacterListView extends StatefulWidget {
  final GetEnumValue getEnumValue;
  // Parameter initialHouseFilter dihapus karena filter House dihapus
  // final House? initialHouseFilter;

  const FilteredCharacterListView({
    super.key,
    required this.getEnumValue,
    // this.initialHouseFilter, // Hapus dari konstruktor
  });

  @override
  State<FilteredCharacterListView> createState() =>
      _FilteredCharacterListViewState();
}

class _FilteredCharacterListViewState extends State<FilteredCharacterListView> {
  // Future untuk fetching data awal dari API
  late Future<List<CharacterList>> _fetchCharactersFuture;

  // Menyimpan semua karakter yang diambil dari API (data master)
  List<CharacterList> _allCharacters = [];

  // _allSpecies tidak lagi digunakan jika hanya search, tapi bisa disimpan jika ada potensi penggunaan lain
  List<String> _allSpecies = [];

  // Karakter yang sedang ditampilkan setelah pencarian diterapkan
  List<CharacterList> _displayedCharacters = [];

  // FilterSelections dan _currentFilterSelections dihapus karena fungsionalitas filter dihapus
  // FilterSelections _currentFilterSelections = {
  //   'house': <House>{},
  //   'gender': <Gender>{},
  //   'species': <String>{},
  //   'ancestry': <Ancestry>{},
  //   'eyeColour': <EyeColour>{},
  //   'hairColour': <HairColour>{},
  //   'patronus': <Patronus>{},
  // };

  // _activeHouseFilter dihapus karena filter House dihapus
  // House? _activeHouseFilter;

  // Variabel untuk fungsionalitas pencarian
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Inisialisasi filter house dihapus
    // if (widget.initialHouseFilter != null &&
    //     widget.initialHouseFilter != House.EMPTY) {
    //   _currentFilterSelections['house']!.add(widget.initialHouseFilter!);
    //   _activeHouseFilter = widget.initialHouseFilter;
    // } else {
    //   _activeHouseFilter = null;
    // }

    _fetchCharactersFuture = getCar();
    _fetchCharactersFuture
        .then((characters) {
          setState(() {
            _allCharacters = characters;
            // Ekstrak spesies unik (tetap ada jika mungkin berguna di masa depan atau untuk debug)
            Set<String> uniqueSpecies =
                characters
                    .map((char) => char.species)
                    .whereType<String>()
                    .toSet();
            _allSpecies = uniqueSpecies.toList()..sort();
            _applySearch(); // Panggil fungsi pencarian awal setelah data dimuat
          });
        })
        .catchError((error) {
          log("Error fetching characters: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load characters: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _allCharacters = [];
            _displayedCharacters = [];
          });
        });

    // Listener untuk search controller
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Method to reload all characters (used in error retry button)
  void _loadAllCharacters() {
    setState(() {
      _fetchCharactersFuture = getCar();
      // Optionally clear previous data if you want to reset the state
      // _allCharacters = [];
      // _displayedCharacters = [];
    });
  }

  // Fungsi untuk menangani perubahan teks di search bar
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _applySearch(); // Terapkan pencarian setiap kali teks berubah
    });
  }

  // Fungsi untuk toggle search bar visibility
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchQuery = "";
        _applySearch(); // Terapkan pencarian setelah menutup search bar
      }
    });
  }

  // Fungsi untuk menerapkan pencarian ke _allCharacters
  void _applySearch() {
    List<CharacterList> tempSearchedCharacters =
        _allCharacters.where((char) {
          // Logika pencarian: berdasarkan nama, house, atau species
          bool matchesSearchQuery = true;
          if (_searchQuery.isNotEmpty) {
            final lowerCaseQuery = _searchQuery.toLowerCase();
            matchesSearchQuery =
                (char.name?.toLowerCase().contains(lowerCaseQuery) ?? false) ||
                (char.house != null &&
                    (widget
                            .getEnumValue(char.house, houseValues)
                            ?.toLowerCase()
                            .contains(lowerCaseQuery) ??
                        false)) ||
                (char.species?.toLowerCase().contains(lowerCaseQuery) ?? false);
          }
          return matchesSearchQuery;
        }).toList();

    setState(() {
      _displayedCharacters =
          tempSearchedCharacters; // Perbarui daftar karakter yang ditampilkan
    });
  }

  // Fungsi helper untuk mendapatkan warna rumah (tetap dipertahankan untuk tampilan kartu)
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

  // _showFilterDialog dihapus
  // void _showFilterDialog() async {
  //   // ... (logika dialog filter yang dihapus)
  // }

  // Membangun ringkasan (sekarang hanya untuk search query)
  String _buildSummary() {
    if (_searchQuery.isNotEmpty) {
      return 'Searching for: "$_searchQuery"';
    } else {
      return 'Showing all characters.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Warna AppBar tetap bisa disesuaikan, tapi _activeHouseFilter sudah dihapus
    Color mainAccentColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching // Tampilkan TextField jika sedang mencari
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search characters...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        _searchController.clear();
                        _searchQuery = "";
                        _applySearch(); // Kosongkan search dan perbarui daftar
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
                : const Text(
                  // Jika tidak mencari, tampilkan judul biasa
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
            _isSearching
                ? Icons.arrow_back
                : Icons.arrow_back, // Ikon tetap panah kembali
          ),
          onPressed: () {
            if (_isSearching) {
              _toggleSearch(); // Jika sedang mencari, tutup search bar
            } else {
              Navigator.pop(context); // Jika tidak, kembali ke layar sebelumnya
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching
                  ? Icons.search_off
                  : Icons.search, // Ikon toggle search
            ),
            onPressed: _toggleSearch, // Panggil fungsi toggle search
            tooltip: _isSearching ? 'Close Search' : 'Search Characters',
          ),
          // Tombol filter_list dihapus
          // IconButton(
          //   icon: const Icon(Icons.filter_list),
          //   onPressed: _showFilterDialog,
          //   tooltip: 'Apply Filters',
          // ),
        ],
      ),
      body: Container(
        color: mainAccentColor.withOpacity(0.05),
        child: Column(
          children: [
            // Bagian ringkasan
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
                _buildSummary(), // Menggunakan _buildSummary
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
                future: _fetchCharactersFuture,
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
                            onPressed: () => _loadAllCharacters(),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainAccentColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    // Jika data baru saja dimuat pertama kali, panggil _applySearch
                    if (_displayedCharacters.isEmpty &&
                        _allCharacters.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _applySearch();
                      });
                      return Center(
                        child: CircularProgressIndicator(
                          color: mainAccentColor,
                        ),
                      );
                    }

                    if (_displayedCharacters.isEmpty) {
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
                                  ? 'No characters found matching "$_searchQuery".' // Pesan disesuaikan
                                  : 'No characters loaded yet or no characters to display.', // Pesan disesuaikan
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                              ),
                            ),
                            // Tombol Clear All Filters dihapus karena tidak ada filter
                            if (_searchQuery
                                .isNotEmpty) // Tampilkan tombol Clear Search jika ada query
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _searchQuery = "";
                                      _applySearch(); // Reset dan terapkan pencarian
                                    });
                                  },
                                  icon: const Icon(Icons.clear),
                                  label: const Text(
                                    'Clear Search',
                                  ), // Label disesuaikan
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainAccentColor
                                        .withOpacity(0.7),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: _displayedCharacters.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = _displayedCharacters[index];
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
