import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/api/get_character.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart';
import 'package:ppkd_b2/tugas_14/view/character_list_detail.dart';
import 'package:ppkd_b2/tugas_14/view/filtered_list.dart';
import 'package:ppkd_b2/tugas_14/view/staff/staff.dart';
import 'package:ppkd_b2/tugas_14/view/student/student.dart';
import 'package:ppkd_b2/tugas_14/view/filtered_character_list_view.dart'; // Import file baru ini

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});
  static const String id = "/list";

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  // State untuk menyimpan rumah yang sedang difilter
  House? _currentFilterHouse;
  String _appBarTitle = "Hogwarts Characters";
  Color _appBarColor = Colors.deepPurple; // Warna AppBar default
  Color _backgroundColor = Colors.white; // Warna background default

  // Helper method to get the string value of an enum, handling nulls and the EMPTY case
  String? _getEnumValue(dynamic enumValue, EnumValues enumValues) {
    if (enumValue == null || enumValue == enumValues.map[""]) {
      return null;
    }
    return enumValues.reverse[enumValue];
  }

  // Helper untuk mendapatkan warna berdasarkan House
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
        return Colors.deepPurple; // Warna default jika tidak ada rumah
    }
  }

  // Widget untuk membuat kartu rumah yang bisa diklik
  Widget _buildHouseCard(
    BuildContext context, {
    required House house,
    required String imagePath,
    required Color color,
  }) {
    String? houseName = _getEnumValue(house, houseValues);

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilterHouse = house; // Set filter saat kartu diklik
          _appBarTitle = '$houseName Characters'; // Perbarui judul AppBar
          _appBarColor = color; // Perbarui warna AppBar
          _backgroundColor = color.withOpacity(
            0.05,
          ); // Perbarui warna background
        });
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: color.withOpacity(0.1)),
                child: Center(
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 50,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: color,
                alignment: Alignment.center,
                child: Text(
                  houseName ?? 'Unknown House',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan tampilan Home (kartu rumah)
  Widget _buildHomeView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose Your House:",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildHouseCard(
                  context,
                  house: House.GRYFFINDOR,
                  imagePath:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Gryffindor_House.svg/1200px-Gryffindor_House.svg.png',
                  color: _getHouseColor(House.GRYFFINDOR),
                ),
                _buildHouseCard(
                  context,
                  house: House.SLYTHERIN,
                  imagePath:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Slytherin_House.svg/1200px-Slytherin_House.svg.png',
                  color: _getHouseColor(House.SLYTHERIN),
                ),
                _buildHouseCard(
                  context,
                  house: House.HUFFLEPUFF,
                  imagePath:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Hufflepuff_House.svg/1200px-Hufflepuff_House.svg.png',
                  color: _getHouseColor(House.HUFFLEPUFF),
                ),
                _buildHouseCard(
                  context,
                  house: House.RAVENCLAW,
                  imagePath:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Ravenclaw_House.svg/1200px-Ravenclaw_House.svg.png',
                  color: _getHouseColor(House.RAVENCLAW),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor, // Mengatur warna background Scaffold
      appBar: AppBar(
        title: Text(
          _appBarTitle, // Judul AppBar dinamis
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _appBarColor, // Warna AppBar dinamis
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading:
            _currentFilterHouse != null
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _currentFilterHouse = null; // Hapus filter
                      _appBarTitle =
                          "Hogwarts Characters"; // Kembali ke judul default
                      _appBarColor =
                          Colors.deepPurple; // Kembali ke warna AppBar default
                      _backgroundColor =
                          Colors.white; // Kembali ke warna background default
                    });
                  },
                )
                : null,
      ),
      drawer:
          _currentFilterHouse == null
              ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade700,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Hogwarts Directory',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Explore the magic!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shield,
                        color: Colors.deepPurple.shade700,
                      ),
                      title: const Text(
                        'Hogwarts Staff',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HogwartsStaffScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Colors.deepPurple.shade700,
                      ),
                      title: const Text(
                        'Hogwarts Students',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HogwartsStudentScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.grey.shade600,
                      ),
                      title: const Text(
                        'About App',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showAboutDialog(
                          context: context,
                          applicationName: 'Hogwarts Directory',
                          applicationVersion: '1.0.0',
                          applicationLegalese:
                              '© 2024 Your Company. All rights reserved.',
                          children: [
                            const Text(
                              'This app provides character information from the Harry Potter universe.',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
              : null,
      body:
          _currentFilterHouse == null
              ? _buildHomeView()
              : FilteredCharacterListView(
                selectedHouse: _currentFilterHouse!,
                getEnumValue: _getEnumValue,
                // Meneruskan warna latar belakang dari state parent
                backgroundColor: _backgroundColor,
              ),
    );
  }
}
