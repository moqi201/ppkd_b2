import 'package:flutter/material.dart';
import 'package:ppkd_b2/study_2/screen/hewan_detail.dart';
import 'package:ppkd_b2/study_2/screen/hewan_edit.dart';
import 'package:ppkd_b2/study_2/screen/hewan_form.dart';
import 'package:ppkd_b2/study_2/screen/hewan_list.dart';
import 'package:ppkd_b2/study_2/model/model_hewan.dart';
import 'package:ppkd_b2/tugas_13/CRUD/edit_siswa.dart';
import 'package:ppkd_b2/tugas_13/CRUD/form_siswa.dart';
import 'package:ppkd_b2/tugas_13/screen/list_siswa.dart';
import 'package:ppkd_b2/tugas_13/screen/list_sekolah.dart';
import 'package:ppkd_b2/tugas_13/screen/dashboard_siswa.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ppkd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const ListSiswaScreen(),
        TentangSekolahScreen.id: (context) => const TentangSekolahScreen(),
        HewanFormScreen.id: (context) => const HewanFormScreen(),
        DashboardSiswa.id: (context) => const DashboardSiswa(),
        TambahSiswa.id : (context) => const TambahSiswa(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HewanDetailScreen.id:
            final hewan = settings.arguments as ModelHewan;
            return MaterialPageRoute(
              builder: (_) => HewanDetailScreen(hewan: hewan),
            );
          case HewanEditScreen.id:
            final hewan = settings.arguments as ModelHewan;
            return MaterialPageRoute(
              builder: (_) => HewanEditScreen(hewan: hewan),
            );
        }
        return null;
      },
    );
  }
}
