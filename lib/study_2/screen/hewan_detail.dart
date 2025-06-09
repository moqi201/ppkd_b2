import 'dart:io';
import 'package:flutter/material.dart';
import '../model/model_hewan.dart';

class HewanDetailScreen extends StatelessWidget {
  static const String id = "/hewan_detail";
  final ModelHewan hewan;

  const HewanDetailScreen({super.key, required this.hewan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Detail Hewan'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: hewan.foto.isNotEmpty && File(hewan.foto).existsSync()
                  ? Image.file(
                      File(hewan.foto),
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey[200],
                      child: const Icon(Icons.pets, size: 80, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItem('Nama', hewan.nama),
                    const SizedBox(height: 12),
                    _buildItem('Jenis', hewan.jenis),
                    const SizedBox(height: 12),
                    _buildItem('Umur', '${hewan.umur} tahun'),
                    const SizedBox(height: 12),
                    _buildItem('Berat', '${hewan.berat} kg'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
