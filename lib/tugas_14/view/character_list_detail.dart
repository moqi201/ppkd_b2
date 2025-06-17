import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart'; // Ensure this path is correct

class CharacterDetailScreen extends StatelessWidget {
  final CharacterList character;

  const CharacterDetailScreen({super.key, required this.character});

  // Helper method to get the string value of an enum, handling nulls and the EMPTY case
  String? _getEnumValue(dynamic enumValue, EnumValues enumValues) {
    if (enumValue == null || enumValue == enumValues.map[""]) {
      // Check for null or the "EMPTY" enum case
      return null;
    }
    return enumValues.reverse[enumValue];
  }

  @override
  Widget build(BuildContext context) {
    // Get the string representation of the house, handling potential null or empty house
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Character Image
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.deepPurple.shade100,
              backgroundImage:
                  character.image != null && character.image!.isNotEmpty
                      ? NetworkImage(character.image!)
                      : null,
              child:
                  character.image == null || character.image!.isEmpty
                      ? Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.deepPurple.shade400,
                      )
                      : null,
            ),
            const SizedBox(height: 20),

            // Character Name
            Text(
              character.name ?? 'No Name',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),

            // House Chip
            if (houseName != null && houseName.isNotEmpty)
              Chip(
                label: Text(houseName), // Use the fetched string name
                backgroundColor: Colors.deepPurple.shade50,
                labelStyle: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.w600,
                ),
                avatar: Icon(Icons.school, color: Colors.deepPurple.shade400),
              ),
            const Divider(
              height: 40,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            ),

            // Character Details
            _buildSectionTitle("General Information"),
            _buildInfoCard("Species", character.species),
            _buildInfoCard("Gender", genderName), // Use the fetched string name
            _buildInfoCard("Date of Birth", character.dateOfBirth),
            _buildInfoCard("Year of Birth", character.yearOfBirth?.toString()),
            _buildInfoCard("Wizard", character.wizard == true ? "Yes" : "No"),
            _buildInfoCard(
              "Ancestry",
              ancestryName,
            ), // Use the fetched string name
            _buildInfoCard(
              "Eye Colour",
              eyeColourName,
            ), // Use the fetched string name
            _buildInfoCard(
              "Hair Colour",
              hairColourName,
            ), // Use the fetched string name
            _buildInfoCard(
              "Patronus",
              patronusName,
            ), // Use the fetched string name
            _buildInfoCard(
              "Hogwarts Student",
              character.hogwartsStudent == true ? "Yes" : "No",
            ),
            _buildInfoCard(
              "Hogwarts Staff",
              character.hogwartsStaff == true ? "Yes" : "No",
            ),
            _buildInfoCard("Actor", character.actor),
            _buildInfoCard("Alive", character.alive == true ? "Yes" : "No"),

            // Wand Information
            if (character.wand != null &&
                (character.wand!.wood != null &&
                        character
                            .wand!
                            .wood!
                            .isNotEmpty || // Add isNotEmpty check
                    character.wand!.core != null &&
                        character
                            .wand!
                            .core!
                            .isNotEmpty || // Add isNotEmpty check
                    character.wand!.length != null))
              Column(
                children: [
                  const SizedBox(height: 20),
                  _buildSectionTitle("Wand Details"),
                  _buildInfoCard("Wood", character.wand?.wood),
                  _buildInfoCard("Core", character.wand?.core),
                  _buildInfoCard(
                    "Length",
                    character.wand?.length?.toStringAsFixed(2),
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
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  /// Builds a consistent info card for displaying character attributes.
  Widget _buildInfoCard(String label, String? value) {
    // Also consider trimming the value in case of whitespace-only strings
    if (value == null ||
        value.trim().isEmpty ||
        value.toLowerCase() == "null" ||
        value.toLowerCase() == "empty") {
      return const SizedBox.shrink(); // Don't show if value is null or empty, or "null", or "empty"
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
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
