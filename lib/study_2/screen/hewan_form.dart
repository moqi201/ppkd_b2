import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../database/db_helper.dart';
import '../model/model_hewan.dart';

class HewanFormScreen extends StatefulWidget {
  static const String id = "/hewan_form";
  const HewanFormScreen({super.key});

  @override
  State<HewanFormScreen> createState() => _HewanFormScreenState();
}

class _HewanFormScreenState extends State<HewanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jenisController = TextEditingController();
  final _umurController = TextEditingController();
  final _beratController = TextEditingController();

  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage =
          await File(picked.path).copy('${appDir.path}/$fileName');

      setState(() {
        _imagePath = savedImage.path;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih gambar terlebih dahulu!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final hewan = ModelHewan(
      nama: _namaController.text.trim(),
      jenis: _jenisController.text.trim(),
      umur: int.tryParse(_umurController.text) ?? 0,
      berat: double.tryParse(_beratController.text) ?? 0.0,
      foto: _imagePath!,
    );

    await DbHelper.insertHewan(hewan);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Tambah Hewan'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_namaController, 'Nama Hewan'),
              const SizedBox(height: 14),
              _buildTextField(_jenisController, 'Jenis Hewan'),
              const SizedBox(height: 14),
              _buildTextField(_umurController, 'Umur (tahun)', isNumber: true),
              const SizedBox(height: 14),
              _buildTextField(_beratController, 'Berat (kg)', isNumber: true),
              const SizedBox(height: 20),
              _buildImagePicker(),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (val) => val == null || val.isEmpty ? '$label wajib diisi' : null,
    );
  }

  Widget _buildImagePicker() {
    return Row(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _pickImage,
          icon: const Icon(Icons.image_outlined),
          label: const Text('Pilih Gambar'),
        ),
        const SizedBox(width: 16),
        _imagePath != null && File(_imagePath!).existsSync()
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imagePath!),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
            : const Text('Belum ada gambar', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
