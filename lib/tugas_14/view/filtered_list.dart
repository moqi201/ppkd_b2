// lib/tugas_14/view/filtered_character_list_view.dart
import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/api/get_character.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart';
import 'package:ppkd_b2/tugas_14/view/character_list_detail.dart';

// Definisi typedef untuk fungsi helper _getEnumValue
typedef GetEnumValue =
    String? Function(dynamic enumValue, EnumValues enumValues);

class FilteredCharacterListView extends StatelessWidget {
  final House selectedHouse;
  final GetEnumValue getEnumValue; // Menerima helper method dari parent

  const FilteredCharacterListView({
    super.key,
    required this.selectedHouse,
    required this.getEnumValue,
  });

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
        return Colors.grey.shade700; // Warna default jika tidak ada rumah
    }
  }

  // Helper untuk mendapatkan URL gambar berdasarkan House
  String _getHouseImagePath(House house) {
    switch (house) {
      case House.GRYFFINDOR:
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Gryffindor_House.svg/1200px-Gryffindor_House.svg.png';
      case House.SLYTHERIN:
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Slytherin_House.svg/1200px-Slytherin_House.svg.png';
      case House.HUFFLEPUFF:
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Hufflepuff_House.svg/1200px-Hufflepuff_House.svg.png';
      case House.RAVENCLAW:
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Ravenclaw_House.svg/1200px-Ravenclaw_House.svg.png';
      default:
        return ''; // Return empty string or a placeholder image URL
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan warna dan path gambar untuk rumah yang dipilih
    final Color houseColor = _getHouseColor(selectedHouse);
    final String houseImagePath = _getHouseImagePath(selectedHouse);
    final String? houseName = getEnumValue(selectedHouse, houseValues);

    return Column(
      children: [
        // Bagian atas dengan gambar rumah dan background warna
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: houseColor.withOpacity(0.1), // Background warna rumah
            border: Border(
              bottom: BorderSide(
                color: houseColor, // Border bawah dengan warna rumah
                width: 2.0,
              ),
            ),
          ),
          child: Column(
            children: [
              if (houseImagePath.isNotEmpty)
                Image.network(
                  houseImagePath,
                  height: 120, // Ukuran gambar yang sesuai
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.broken_image, color: houseColor, size: 80),
                ),
              if (houseImagePath.isNotEmpty) const SizedBox(height: 10),
              Text(
                'Characters of ${houseName ?? 'this House'}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: houseColor, // Warna teks sesuai rumah
                ),
              ),
            ],
          ),
        ),
        // Daftar karakter yang difilter
        Expanded(
          child: FutureBuilder<List<CharacterList>>(
            future: getCar(), // Ambil semua data karakter
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: houseColor),
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
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                List<CharacterList> characters = snapshot.data!;

                // Lakukan filter berdasarkan selectedHouse
                characters =
                    characters
                        .where((char) => char.house == selectedHouse)
                        .toList();

                if (characters.isEmpty) {
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
                          'No characters found for ${houseName ?? 'this house'}.',
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
                  itemCount: characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = characters[index];
                    final String? characterHouseName = getEnumValue(
                      user.house,
                      houseValues,
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                        subtitle: Text(
                          characterHouseName != null &&
                                  characterHouseName.isNotEmpty
                              ? characterHouseName
                              : 'No House',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.deepPurple.shade100,
                          backgroundImage:
                              user.image != null && user.image!.isNotEmpty
                                  ? NetworkImage(user.image!)
                                  : null,
                          child:
                              user.image == null || user.image!.isEmpty
                                  ? Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.deepPurple.shade400,
                                  )
                                  : null,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.deepPurple,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      CharacterDetailScreen(character: user),
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
    );
  }
}
