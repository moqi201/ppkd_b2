import 'package:flutter/material.dart';
import 'package:ppkd_b2/meet_1/meet_1.dart';
import 'package:ppkd_b2/tugas_satu_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ppkd',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 119, 255)),
      ),
      home: ProfilPage(),
    );
  }
}

