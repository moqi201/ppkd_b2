import 'package:flutter/material.dart';
import 'package:ppkd_b2/meet_4/tugas_tiga.dart';

class Meet11A extends StatefulWidget {
  const Meet11A({super.key});

  @override
  State<Meet11A> createState() => _Meet11AState();
}

class _Meet11AState extends State<Meet11A> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet 11"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // Navigasi ke halaman TugasTiga dan hapus semua rute sebelumnya
            // sehingga pengguna tidak dapat kembali ke halaman Meet 11
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TugasTiga()),
              (route) => false,
            );
          },
          child: Text(
            "Ini adalah materi Meet 11",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
