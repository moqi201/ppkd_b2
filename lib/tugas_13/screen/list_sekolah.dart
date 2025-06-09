// Screen/tentang_sekolah.dart
import 'package:flutter/material.dart';

class TentangSekolahScreen extends StatelessWidget {
  static const String id = "/list_sekolah";
  const TentangSekolahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tentang Sekolah")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama Sekolah: SMK Negeri Contoh", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Alamat: Jl. Pendidikan No.123", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Kepala Sekolah: Ibu Siti Aminah", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Tahun Berdiri: 2005", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
