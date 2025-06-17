import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_14/api/get_character.dart';
import 'package:ppkd_b2/tugas_14/model/character_model.dart';
import 'package:ppkd_b2/tugas_14/view/character_list_detail.dart';

class HogwartsStudentScreen extends StatelessWidget {
  const HogwartsStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hogwarts Students')),
      body: FutureBuilder<List<CharacterList>>(
        future: getCar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final students =
                snapshot.data!
                    .where((char) => char.hogwartsStudent == true)
                    .toList();
            return ListView.builder(
              
              itemCount: students.length,
              itemBuilder: (context, index) {
                final user = students[index];
                return ListTile(
                  
                  title: Text(user.name ?? 'No Name'),
                  subtitle: Text('${user.house ?? 'No House'}'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.image ?? ''),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CharacterDetailScreen(character: user),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        },
      ),
    );
  }
}
