// lib/tugas_14/widget/fillter_dialog_widget.dart
import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart'; // Pastikan path ini benar

typedef FilterSelections = Map<String, Set<dynamic>>;
typedef GetEnumValue =
    String? Function(dynamic enumValue, EnumValues enumValues);

class FilterDialogWidget extends StatefulWidget {
  final FilterSelections initialSelections;
  final GetEnumValue getEnumValue;
  final List<String> allSpecies;
  final House? activeHouseFilter;

  const FilterDialogWidget({
    super.key,
    required this.initialSelections,
    required this.getEnumValue,
    required this.allSpecies,
    this.activeHouseFilter,
  });

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  final List<House> _allHouses = [
    House.GRYFFINDOR,
    House.SLYTHERIN,
    House.HUFFLEPUFF,
    House.RAVENCLAW,
    House.EMPTY,
  ];
  final List<Gender> _allGenders = [Gender.FEMALE, Gender.MALE, Gender.EMPTY];
  final List<Ancestry> _allAncestries = [
    Ancestry.PURE_BLOOD,
    Ancestry.HALF_BLOOD,
    Ancestry.MUGGLEBORN,
    Ancestry.MUGGLE,
    Ancestry.HALF_VEELA,
    Ancestry.QUARTER_VEELA,
    Ancestry.SQUIB,
    Ancestry.EMPTY,
  ];
  final List<EyeColour> _allEyeColours = [
    EyeColour.BLUE,
    EyeColour.BROWN,
    EyeColour.GREEN,
    EyeColour.GREY,
    EyeColour.HAZEL,
    EyeColour.BLACK,
    EyeColour.DARK,
    EyeColour.AMBER,
    EyeColour.ORANGE,
    EyeColour.YELLOW,
    EyeColour.PALE_SILVERY,
    EyeColour.SCARLET,
    EyeColour.SILVER,
    EyeColour.WHITE,
    EyeColour.BEADY,
    EyeColour.EMPTY,
  ];
  final List<HairColour> _allHairColours = [
    HairColour.BLACK,
    HairColour.BROWN,
    HairColour.BLOND,
    HairColour.BLONDE,
    HairColour.GINGER,
    HairColour.RED,
    HairColour.GREY,
    HairColour.WHITE,
    HairColour.DARK,
    HairColour.DULL,
    HairColour.GREEN,
    HairColour.PURPLE,
    HairColour.SANDY,
    HairColour.SILVER,
    HairColour.TAWNY,
    HairColour.BALD,
    HairColour.EMPTY,
  ];
  final List<Patronus> _allPatronus = [
    Patronus.BOAR,
    Patronus.DOE,
    Patronus.EMPTY,
    Patronus.GOAT,
    Patronus.HARE,
    Patronus.HORSE,
    Patronus.JACK_RUSSELL_TERRIER,
    Patronus.LYNX,
    Patronus.NON_CORPOREAL,
    Patronus.OTTER,
    Patronus.PERSIAN_CAT,
    Patronus.PHOENIX,
    Patronus.STAG,
    Patronus.SWAN,
    Patronus.TABBY_CAT,
    Patronus.WEASEL,
    Patronus.WOLF,
  ];

  late FilterSelections _currentSelections;

  @override
  void initState() {
    super.initState();
    // Penting: Buat salinan dalam karena Set bisa dimodifikasi dari luar
    _currentSelections = {
      'house': Set.from(widget.initialSelections['house'] ?? {}),
      'gender': Set.from(widget.initialSelections['gender'] ?? {}),
      'species': Set.from(widget.initialSelections['species'] ?? {}),
      'ancestry': Set.from(widget.initialSelections['ancestry'] ?? {}),
      'eyeColour': Set.from(widget.initialSelections['eyeColour'] ?? {}),
      'hairColour': Set.from(widget.initialSelections['hairColour'] ?? {}),
      'patronus': Set.from(widget.initialSelections['patronus'] ?? {}),
    };
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

  String _getHouseImagePath(House house) {
    switch (house) {
      case House.GRYFFINDOR:
        return 'assets/images/gripindor.jpg';
      case House.SLYTHERIN:
        return 'assets/images/sliterin.jpg';
      case House.HUFFLEPUFF:
        return 'assets/images/hup.jpg';
      case House.RAVENCLAW:
        return 'assets/images/rv.jpg';
      default:
        return '';
    }
  }

  Widget _buildFilterCategory<T>(
    String title,
    String key,
    List<T> allOptions,
    EnumValues<T>? enumValues,
  ) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children:
          allOptions.map((option) {
            String optionText;
            if (enumValues != null) {
              optionText = widget.getEnumValue(option, enumValues) ?? 'N/A';
              if (option == enumValues.map[""]) {
                optionText = 'N/A (Not specified)';
              }
            } else {
              optionText = option.toString();
              if (optionText.isEmpty) {
                optionText = 'N/A (Not specified)';
              }
            }

            final Set<dynamic> selectedSet =
                _currentSelections[key]!; // Gunakan dynamic karena Set bisa beda tipe
            final bool isSelected = selectedSet.contains(option);

            return CheckboxListTile(
              title: Text(optionText),
              value: isSelected,
              onChanged: (bool? newValue) {
                setState(() {
                  if (newValue!) {
                    selectedSet.add(option);
                  } else {
                    selectedSet.remove(option);
                  }
                });
              },
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color dialogThemeColor = Colors.deepPurple;
    String dialogTitle = 'Filter Characters';
    String dialogImagePath = '';

    if (widget.activeHouseFilter != null &&
        widget.activeHouseFilter != House.EMPTY) {
      dialogThemeColor = _getHouseColor(widget.activeHouseFilter!);
      dialogTitle =
          'Filter by ${widget.getEnumValue(widget.activeHouseFilter, houseValues) ?? 'House'}';
      dialogImagePath = _getHouseImagePath(widget.activeHouseFilter!);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: dialogThemeColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (dialogImagePath.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        dialogImagePath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Text(
                    dialogTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFilterCategory<House>(
                    'House',
                    'house',
                    _allHouses,
                    houseValues,
                  ),
                  _buildFilterCategory<Gender>(
                    'Gender',
                    'gender',
                    _allGenders,
                    genderValues,
                  ),
                  _buildFilterCategory<String>(
                    'Species',
                    'species',
                    widget.allSpecies,
                    null,
                  ),
                  _buildFilterCategory<Ancestry>(
                    'Ancestry',
                    'ancestry',
                    _allAncestries,
                    ancestryValues,
                  ),
                  _buildFilterCategory<EyeColour>(
                    'Eye Colour',
                    'eyeColour',
                    _allEyeColours,
                    eyeColourValues,
                  ),
                  _buildFilterCategory<HairColour>(
                    'Hair Colour',
                    'hairColour',
                    _allHairColours,
                    hairColourValues,
                  ),
                  _buildFilterCategory<Patronus>(
                    'Patronus',
                    'patronus',
                    _allPatronus,
                    patronusValues,
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        // Reset semua filter di dalam dialog ini
                        _currentSelections = {
                          'house': <House>{},
                          'gender': <Gender>{},
                          'species': <String>{},
                          'ancestry': <Ancestry>{},
                          'eyeColour': <EyeColour>{},
                          'hairColour': <HairColour>{},
                          'patronus': <Patronus>{},
                        };
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: dialogThemeColor,
                      side: BorderSide(color: dialogThemeColor),
                    ),
                    child: const Text('Reset All Filters'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(
                        _currentSelections,
                      ); // Kirim filter yang sudah di-reset/diubah
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dialogThemeColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply Filter'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
