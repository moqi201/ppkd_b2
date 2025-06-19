import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart'; // Ensure this path is correct

class CharacterDetailScreen extends StatelessWidget {
  final CharacterList character;
  // Hapus 'final House selectedHouse;' karena kita akan menggunakan character.house
  const CharacterDetailScreen({super.key, required this.character});

  // Helper method to get the string value of an enum, handling nulls and the EMPTY case
  String? _getEnumValue(dynamic enumValue, EnumValues enumValues) {
    if (enumValue == null || enumValue == enumValues.map[""]) {
      // Check for null or the "EMPTY" enum case
      return null;
    }
    return enumValues.reverse[enumValue];
  }

  // Helper method to get the appropriate color for the house
  Color _getHouseColor(House? house) {
    // Terima House? karena bisa null
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
        return Colors
            .deepPurple; // Warna default jika tidak ada rumah atau rumah tidak dikenal
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan warna berdasarkan rumah karakter yang sedang ditampilkan
    final Color houseMainColor = _getHouseColor(character.house);
    // Dapatkan warna untuk teks kontras (putih atau hitam)
    final Color textColor =
        houseMainColor.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;

    final String? houseName = _getEnumValue(character.house, houseValues);
    final String? genderName = _getEnumValue(character.gender, genderValues);
    final String? ancestryName = _getEnumValue(
      character.ancestry,
      ancestryValues,
    );
    final String? eyeColourName = _getEnumValue(
      character.eyeColour,
      eyeColourValues,
    );
    final String? hairColourName = _getEnumValue(
      character.hairColour,
      hairColourValues,
    );
    final String? patronusName = _getEnumValue(
      character.patronus,
      patronusValues,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name ?? 'Unknown Character',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ), // Warna teks sesuai rumah
        ),
        backgroundColor: houseMainColor, // Warna AppBar sesuai rumah karakter
        foregroundColor:
            textColor, // Warna ikon dan teks kembali sesuai kontras
      ),
      backgroundColor: houseMainColor.withOpacity(
        0.05,
      ), // Background layar detail dengan opasitas
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Character Image
            CircleAvatar(
              radius: 80,
              backgroundColor: houseMainColor.withOpacity(
                0.2,
              ), // Warna background avatar sesuai rumah
              backgroundImage:
                  character.image != null && character.image!.isNotEmpty
                      ? NetworkImage(character.image!)
                      : null,
              child:
                  character.image == null || character.image!.isEmpty
                      ? Icon(
                        Icons.person,
                        size: 40,
                        color:
                            houseMainColor, // Warna ikon default sesuai rumah
                      )
                      : null,
            ),
            const SizedBox(height: 20),

            // Character Name
            Text(
              character.name ?? 'No Name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: houseMainColor, // Warna nama sesuai rumah
              ),
            ),
            const SizedBox(height: 8),

            // House Chip
            if (houseName != null && houseName.isNotEmpty)
              Chip(
                label: Text(houseName), // Use the fetched string name
                backgroundColor: houseMainColor.withOpacity(
                  0.1,
                ), // Background chip sesuai rumah
                labelStyle: TextStyle(
                  color: houseMainColor, // Warna teks chip sesuai rumah
                  fontWeight: FontWeight.w600,
                ),
                avatar: Icon(
                  Icons.school,
                  color: houseMainColor,
                ), // Warna ikon chip sesuai rumah
              ),
            Divider(
              height: 40,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
              color: houseMainColor.withOpacity(
                0.5,
              ), // Warna divider sesuai rumah
            ),

            // Character Details
            _buildSectionTitle("General Information", houseMainColor),
            _buildInfoCard("Species", character.species, houseMainColor),
            _buildInfoCard("Gender", genderName, houseMainColor),
            _buildInfoCard(
              "Date of Birth",
              character.dateOfBirth,
              houseMainColor,
            ),
            _buildInfoCard(
              "Year of Birth",
              character.yearOfBirth?.toString(),
              houseMainColor,
            ),
            _buildInfoCard(
              "Wizard",
              character.wizard == true ? "Yes" : "No",
              houseMainColor,
            ),
            _buildInfoCard("Ancestry", ancestryName, houseMainColor),
            _buildInfoCard("Eye Colour", eyeColourName, houseMainColor),
            _buildInfoCard("Hair Colour", hairColourName, houseMainColor),
            _buildInfoCard("Patronus", patronusName, houseMainColor),
            _buildInfoCard(
              "Hogwarts Student",
              character.hogwartsStudent == true ? "Yes" : "No",
              houseMainColor,
            ),
            _buildInfoCard(
              "Hogwarts Staff",
              character.hogwartsStaff == true ? "Yes" : "No",
              houseMainColor,
            ),
            _buildInfoCard("Actor", character.actor, houseMainColor),
            _buildInfoCard(
              "Alive",
              character.alive == true ? "Yes" : "No",
              houseMainColor,
            ),

            // Wand Information
            if (character.wand != null &&
                (character.wand!.wood != null &&
                        character.wand!.wood!.isNotEmpty ||
                    character.wand!.core != null &&
                        character.wand!.core!.isNotEmpty ||
                    character.wand!.length != null))
              Column(
                children: [
                  const SizedBox(height: 20),
                  _buildSectionTitle("Wand Details", houseMainColor),
                  _buildInfoCard("Wood", character.wand?.wood, houseMainColor),
                  _buildInfoCard("Core", character.wand?.core, houseMainColor),
                  _buildInfoCard(
                    "Length",
                    character.wand?.length?.toStringAsFixed(2),
                    houseMainColor,
                  ),
                ],
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds a title for a section of information.
  Widget _buildSectionTitle(String title, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: accentColor, // Warna teks judul sesuai rumah
        ),
      ),
    );
  }

  /// Builds a consistent info card for displaying character attributes.
  Widget _buildInfoCard(String label, String? value, Color accentColor) {
    if (value == null ||
        value.trim().isEmpty ||
        value.toLowerCase() == "null" ||
        value.toLowerCase() == "empty") {
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                    accentColor.computeLuminance() > 0.5
                        ? Colors.black87
                        : const Color.fromARGB(
                          255,
                          27,
                          27,
                          27,
                        ), // Warna label kontras
              ),
            ),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: accentColor,
                ), // Warna nilai sesuai rumah
              ),
            ),
          ],
        ),
      ),
    );
  }
}
