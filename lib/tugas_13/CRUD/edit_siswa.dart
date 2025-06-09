import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_13/database/db_helper.dart';
import 'package:ppkd_b2/tugas_13/model/model_siswa.dart';

class EditSiswa extends StatefulWidget {
  static const String id = "/edit_siswa";
  final Siswa siswa;

  const EditSiswa({super.key, required this.siswa});

  @override
  State<EditSiswa> createState() => _EditSiswaState();
}

class _EditSiswaState extends State<EditSiswa> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController kelasController;
  late TextEditingController emailController;
  late TextEditingController imagePathController;

  final DbHelper1 dbHelper = DbHelper1();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.siswa.nama);
    kelasController = TextEditingController(text: widget.siswa.kelas);
    emailController = TextEditingController(text: widget.siswa.email);
    imagePathController = TextEditingController(text: widget.siswa.imagePath);
  }

  void updateData() async {
    if (_formKey.currentState!.validate()) {
      final updatedSiswa = Siswa(
        id: widget.siswa.id,
        nama: namaController.text,
        kelas: kelasController.text,
        email: emailController.text,
        imagePath: imagePathController.text,
      );
      await dbHelper.updateSiswa(updatedSiswa);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Siswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Masukkan nama' : null,
              ),
              TextFormField(
                controller: kelasController,
                decoration: InputDecoration(labelText: 'Kelas'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: imagePathController,
                decoration: InputDecoration(labelText: 'Path Gambar'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateData,
                child: Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
