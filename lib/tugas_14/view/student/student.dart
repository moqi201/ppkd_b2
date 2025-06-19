import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/api/get_character.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart';
import 'package:ppkd_b2/tugas_14/view/character_list_detail.dart';

class HogwartsStudentScreen extends StatefulWidget {
  // Ubah menjadi StatefulWidget
  const HogwartsStudentScreen({super.key});

  @override
  State<HogwartsStudentScreen> createState() => _HogwartsStudentScreenState();
}

class _HogwartsStudentScreenState extends State<HogwartsStudentScreen> {
  late Future<List<CharacterList>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = getCar();
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
        return Colors.deepPurple; // Warna default untuk House.EMPTY atau null
    }
  }

  // Helper untuk mendapatkan string dari enum (sama seperti di file lain)
  String? _getEnumValue(dynamic enumValue, EnumValues enumValues) {
    if (enumValue == null || enumValue == enumValues.map[""]) {
      return null;
    }
    return enumValues.reverse[enumValue];
  }

  @override
  Widget build(BuildContext context) {
    // Warna utama untuk AppBar
    Color mainAccentColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hogwarts Students',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: mainAccentColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: mainAccentColor.withOpacity(
          0.05,
        ), // Latar belakang yang konsisten
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
                      'Failed to load students: ${snapshot.error}',
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
              final students =
                  snapshot.data!
                      .where((char) => char.hogwartsStudent == true)
                      .toList();

              if (students.isEmpty) {
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
                        'No students found.',
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
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final user = students[index];
                  final String? studentHouseName = _getEnumValue(
                    user.house,
                    houseValues,
                  );
                  final Color studentHouseColor = _getHouseColor(
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
                        user.name ?? 'Unknown Student',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color:
                              studentHouseColor, // Warna title berdasarkan House
                        ),
                      ),
                      subtitle: Text(
                        'House: ${studentHouseName ?? 'N/A'} | Species: ${user.species ?? 'N/A'}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: studentHouseColor.withOpacity(
                          0.2,
                        ), // Latar belakang avatar
                        backgroundImage:
                            user.image != null && user.image!.isNotEmpty
                                ? NetworkImage(user.image!)
                                : null,
                        child:
                            user.image == null || user.image!.isEmpty
                                ? Icon(
                                  Icons.person,
                                  size: 30,
                                  color:
                                      studentHouseColor, // Warna ikon jika tidak ada gambar
                                )
                                : null,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: studentHouseColor, // Warna ikon trailing
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
              return const Center(child: Text('An unexpected error occurred.'));
            }
          },
        ),
      ),
    );
  }
}
