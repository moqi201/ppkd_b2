import 'dart:async'; // Untuk Timer

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk SystemChrome
// Pastikan path ini benar sesuai struktur proyek Anda
import 'package:ppkd_b2/tugas_14/view/home_screen.dart';
// Pastikan file filtered_character_list_view.dart dan character_model.dart benar-benar ada di path yang diimport.
// Jika tidak, buat file tersebut atau perbaiki path-nya sesuai struktur folder proyek Anda.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowAnimationController;
  late Animation<double> _glowScaleAnimation;
  late Animation<double> _glowOpacityAnimation;

  late AnimationController _logoAnimationController;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Sembunyikan status bar dan navigation bar untuk pengalaman imersif
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // 1. Animasi Kilauan/Glow Awal (Simulasi)
    _glowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Durasi kilauan
    );
    _glowScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowAnimationController, curve: Curves.easeOut),
    );
    _glowOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _glowAnimationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // 2. Animasi Logo "Harry Potter"
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Durasi muncul logo
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
    );
    _logoScaleAnimation = Tween<double>(
      begin: 0.5, // Mulai dari ukuran 50%
      end: 1.0, // Membesar ke ukuran 100%
    ).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutBack, // Memberikan efek "pantulan" saat muncul
      ),
    );

    // Urutan Animasi
    _glowAnimationController.forward().then((_) {
      // Setelah kilauan, jeda sedikit lalu tampilkan logo
      Future.delayed(const Duration(milliseconds: 200), () {
        _logoAnimationController.forward();
      });
    });

    // Navigasi ke halaman utama setelah semua animasi selesai dan ada jeda yang cukup
    // Sesuaikan total durasi agar sesuai dengan keseluruhan animasi + jeda navigasi
    Timer(const Duration(seconds: 3), () {
      // Contoh: 1s glow + 0.2s jeda + 1.5s logo = ~2.7s + sedikit jeda
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      ); // Kembalikan UI bar
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (context) => CharacterListScreen(
                // initialHouseFilter: null, // Jika tidak ada filter rumah awal
              ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _glowAnimationController.dispose();
    _logoAnimationController.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    ); // Pastikan UI bar dikembalikan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Latar belakang hitam
      body: Stack(
        // Menggunakan Stack untuk tumpukan efek
        fit: StackFit.expand, // Memastikan Stack mengisi seluruh layar
        children: [
          // Efek Kilauan Awal (di tengah layar)
          Center(
            child: AnimatedBuilder(
              animation: _glowAnimationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _glowOpacityAnimation.value,
                  child: Transform.scale(
                    scale:
                        _glowScaleAnimation.value *
                        2.0, // Scale lebih besar untuk efek menyebar
                    child: Container(
                      width: 100, // Ukuran awal efek kilauan
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(
                              0.7,
                            ), // Warna kilauan
                            blurRadius: 50.0, // Radius blur untuk efek glow
                            spreadRadius: 20.0, // Seberapa jauh menyebar
                          ),
                          BoxShadow(
                            // Kilauan kedua untuk intensitas lebih
                            color: Colors.yellow.withOpacity(0.5),
                            blurRadius: 30.0,
                            spreadRadius: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Logo Teks Harry Potter (muncul setelah kilauan)
          Center(
            child: FadeTransition(
              opacity: _logoOpacityAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Image.asset(
                  'assets/images/pter.png', // Path ke foto teks Harry Potter
                  width: 300, // Sesuaikan ukuran logo
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
