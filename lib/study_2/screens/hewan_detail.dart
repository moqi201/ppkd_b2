// screens/hewan_detail_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ppkd_b2/study_2/model/model_hewan.dart';

class HewanDetailScreen extends StatelessWidget {
  final ModelHewan hewan;

  const HewanDetailScreen({super.key, required this.hewan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${hewan.nama}'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  hewan.foto.isNotEmpty
                      ? Image.memory(
                        base64Decode(hewan.foto),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                      : const Icon(Icons.pets, size: 100),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Nama'),
              subtitle: Text(hewan.nama),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Jenis'),
              subtitle: Text(hewan.jenis),
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Umur'),
              subtitle: Text('${hewan.umur} tahun'),
            ),
            ListTile(
              leading: const Icon(Icons.monitor_weight),
              title: const Text('Berat'),
              subtitle: Text('${hewan.berat} kg'),
            ),
          ],
        ),
      ),
    );
  }
}
