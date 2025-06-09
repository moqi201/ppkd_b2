import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../database/db_helper.dart';
import '../model/model_hewan.dart';

class HewanEditScreen extends StatefulWidget {
  static const String id = "/hewan_edit";
  final ModelHewan hewan;
  const HewanEditScreen({super.key, required this.hewan});

  @override
  State<HewanEditScreen> createState() => _HewanEditScreenState();
}

class _HewanEditScreenState extends State<HewanEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _jenisController;
  late TextEditingController _umurController;
  late TextEditingController _beratController;

  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.hewan.nama);
    _jenisController = TextEditingController(text: widget.hewan.jenis);
    _umurController = TextEditingController(text: widget.hewan.umur.toString());
    _beratController = TextEditingController(text: widget.hewan.berat.toString());
    _imagePath = widget.hewan.foto;
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await File(picked.path).copy('${appDir.path}/$fileName');

      setState(() {
        _imagePath = savedImage.path;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih gambar dulu!')),
      );
      return;
    }

    final hewan = ModelHewan(
      id: widget.hewan.id,
      nama: _namaController.text,
      jenis: _jenisController.text,
      umur: int.tryParse(_umurController.text) ?? 0,
      berat: double.tryParse(_beratController.text) ?? 0.0,
      foto: _imagePath!,
    );

    await DbHelper.updateHewan(hewan);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Hewan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Hewan'),
                validator: (val) => val == null || val.isEmpty ? 'Nama harus diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _jenisController,
                decoration: const InputDecoration(labelText: 'Jenis Hewan'),
                validator: (val) => val == null || val.isEmpty ? 'Jenis harus diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _umurController,
                decoration: const InputDecoration(labelText: 'Umur (tahun)'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Umur harus diisi' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _beratController,
                decoration: const InputDecoration(labelText: 'Berat (kg)'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Berat harus diisi' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Ganti Gambar'),
                  ),
                  const SizedBox(width: 10),
                  _imagePath != null && File(_imagePath!).existsSync()
                      ? Image.file(File(_imagePath!), width: 80, height: 80, fit: BoxFit.cover)
                      : const Text('Belum ada gambar'),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
