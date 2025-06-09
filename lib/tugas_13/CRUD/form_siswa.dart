import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_13/database/db_helper.dart';
import 'package:ppkd_b2/tugas_13/model/model_siswa.dart';

class TambahSiswa extends StatefulWidget {
  static const String id = "/form_siswa";
  const TambahSiswa({super.key});

  @override
  State<TambahSiswa> createState() => _TambahSiswaState();
}

class _TambahSiswaState extends State<TambahSiswa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();

  final DbHelper1 dbHelper = DbHelper1();

  void simpanData() async {
    if (_formKey.currentState!.validate()) {
      final siswa = Siswa(
        nama: namaController.text,
        kelas: kelasController.text,
        email: emailController.text,
        imagePath: imagePathController.text,
      );
      await dbHelper.insertSiswa(siswa);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Siswa')),
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
                onPressed: simpanData,
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
