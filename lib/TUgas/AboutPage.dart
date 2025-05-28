import 'package:flutter/material.dart';
import 'package:ppkd_b2/TUgas/theme_provider.dart';
import 'package:provider/provider.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});
  static const String id = "/about_app";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        centerTitle: true,
        backgroundColor:
            Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.black
                : const Color(0xff85193C),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 64, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Aplikasi Demo Tugas 7',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Ini adalah aplikasi demonstrasi untuk menampilkan berbagai komponen input dasar di Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
