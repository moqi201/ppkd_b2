// screens/hewan_form_screen.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppkd_b2/study_2/database/db_helper3.dart';

class HewanFormScreen extends StatefulWidget {
  const HewanFormScreen({super.key});
  static const routeName = '/hewan_form';

  @override
  State<HewanFormScreen> createState() => _HewanFormScreenState();
}

class _HewanFormScreenState extends State<HewanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final jenisController = TextEditingController();
  final umurController = TextEditingController();
  final beratController = TextEditingController();

  final DbHelper3 dbHelper = DbHelper3();
  final ImagePicker _picker = ImagePicker();

  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => _imageBytes = bytes);
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan pilih gambar terlebih dahulu')),
        );
        return;
      }

      await dbHelper.insertHewan({
        'nama': nameController.text,
        'jenis': jenisController.text,
        'umur': int.tryParse(umurController.text) ?? 0,
        'berat': double.tryParse(beratController.text) ?? 0.0,
        'foto': base64Encode(_imageBytes!),
      });

      Navigator.pop(context, true); // Kembali dan refresh data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Hewan"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(nameController, 'Nama Hewan', Icons.pets),
              const SizedBox(height: 12),
              _buildTextField(jenisController, 'Jenis', Icons.category),
              const SizedBox(height: 12),
              _buildTextField(
                umurController,
                'Umur (tahun)',
                Icons.cake,
                TextInputType.number,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                beratController,
                'Berat (kg)',
                Icons.monitor_weight,
                TextInputType.number,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  FilledButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text('Pilih Gambar'),
                    onPressed: _pickImage,
                  ),
                  const SizedBox(width: 12),
                  _imageBytes != null
                      ? Image.memory(_imageBytes!, width: 80, height: 80)
                      : const Text('Belum ada gambar'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, [
    TextInputType keyboardType = TextInputType.text,
  ]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator:
          (value) =>
              (value == null || value.isEmpty)
                  ? '$label tidak boleh kosong'
                  : null,
    );
  }
}
