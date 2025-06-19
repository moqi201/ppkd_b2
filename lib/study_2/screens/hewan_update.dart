import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HewanUpdate extends StatefulWidget {
  const HewanUpdate({super.key});

  @override
  State<HewanUpdate> createState() => _HewanUpdateState();
}

class _HewanUpdateState extends State<HewanUpdate> {
  late TextEditingController nameController;
  late TextEditingController jenisController;
  late TextEditingController umurController;
  late TextEditingController beratController;
  late ImagePicker _picker;
  Uint8List? _imageBytes;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    jenisController = TextEditingController();
    umurController = TextEditingController();
    beratController = TextEditingController();
    _picker = ImagePicker();
  }

  void update() async {
    if (nameController.text.isEmpty ||
        jenisController.text.isEmpty ||
        umurController.text.isEmpty ||
        beratController.text.isEmpty ||
        _imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly')),
      );
      return;
    }

    // Here you would typically call your database update method
    // For example:
    // await dbHelper.updateHewan({
    //   'nama': nameController.text,
    //   'jenis': jenisController.text,
    //   'umur': int.tryParse(umurController.text) ?? 0,
    //   'berat': double.tryParse(beratController.text) ?? 0.0,
    //   'foto': base64Encode(_imageBytes!),
    // });

    Navigator.pop(context, true); // Go back and refresh data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Hewan'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Hewan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: jenisController,
              decoration: InputDecoration(
                labelText: 'Jenis Hewan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: umurController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Umur Hewan (tahun)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: beratController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat Hewan (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Pilih Gambar'),
                  onPressed: () async {
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      _imageBytes = await pickedFile.readAsBytes();
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(width: 10),
                _imageBytes != null
                    ? Image.memory(_imageBytes!, width: 80, height: 80)
                    : const Text('Belum ada gambar'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Update Hewan'),
              onPressed: update,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.all(14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
