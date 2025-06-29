// lib/tugas_14/view/character_list_screen.dart
// ... (imports lainnya tetap sama)
import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart';
import 'package:ppkd_b2/tugas_14/view/filtered_list.dart';
import 'package:ppkd_b2/tugas_14/view/staff/staff.dart';
import 'package:ppkd_b2/tugas_14/view/student/student.dart';
// Import file ini

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});
  static const String id = "/list";

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  String? _getEnumValue(dynamic enumValue, EnumValues enumValues) {
    if (enumValue == null || enumValue == enumValues.map[""]) {
      return null;
    }
    return enumValues.reverse[enumValue];
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

  Widget _buildHouseCard(
    BuildContext context, {
    required House house,
    required String imagePath,
    required Color color,
  }) {
    String? houseName = _getEnumValue(house, houseValues);

    return GestureDetector(
      onTap: () {
        // Sekarang, ketika mengklik kartu rumah, langsung buka daftar karakter
        // dan filter (jika ada) akan dikelola di dalam FilteredCharacterListView.
        // Anda bisa memutuskan apakah ingin langsung menerapkan filter House atau tidak.
        // Untuk contoh ini, kita tidak akan menerapkan filter House awal secara langsung,
        // melainkan membiarkan pengguna memilih dari dialog filter.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => FilteredCharacterListView(
                  getEnumValue: _getEnumValue,
                  // initialHouseFilter: house, // Ini dihapus atau di-comment out
                ),
          ),
        );
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
                  child: Image.asset(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hogwarts Characters",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple.shade700),
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
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.shield, color: Colors.deepPurple.shade700),
              title: const Text(
                'Hogwarts Staff',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
              leading: Icon(Icons.school, color: Colors.deepPurple.shade700),
              title: const Text(
                'Hogwarts Students',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
            ListTile(
              leading: Icon(Icons.group, color: Colors.deepPurple.shade700),
              title: const Text(
                'All Characters (Multi-Filter)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => FilteredCharacterListView(
                          getEnumValue: _getEnumValue,
                        ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.grey.shade600),
              title: const Text(
                'About App',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
      ),
      body: Padding(
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
                    imagePath: 'assets/images/gripindor.jpg',
                    color: _getHouseColor(House.GRYFFINDOR),
                  ),
                  _buildHouseCard(
                    context,
                    house: House.SLYTHERIN,
                    imagePath: 'assets/images/sliterin.jpg',
                    color: _getHouseColor(House.SLYTHERIN),
                  ),
                  _buildHouseCard(
                    context,
                    house: House.HUFFLEPUFF,
                    imagePath: 'assets/images/hup.png',
                    color: _getHouseColor(House.HUFFLEPUFF),
                  ),
                  _buildHouseCard(
                    context,
                    house: House.RAVENCLAW,
                    imagePath: 'assets/images/rv.jpg',
                    color: _getHouseColor(House.RAVENCLAW),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
