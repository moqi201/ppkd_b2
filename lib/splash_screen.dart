// import 'dart:async'; // Untuk Timer (tetap digunakan untuk jeda)

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Untuk SystemChrome
// import 'package:ppkd_b2/tugas_15/api/get_user.dart';
// import 'package:ppkd_b2/tugas_15/view/auth/login.dart'; // <--- PASTIKAN INI ADA DAN PATHNYA BENAR
// // --- KOREKSI PENTING PADA IMPORT DI BAWAH INI ---

// // Ini kemungkinan besar SALAH, seharusnya mengarah ke UserService, bukan get_user.dart
// // import 'package:ppkd_b2/tugas_15/api/get_user.dart'; // <--- HAPUS ATAU KOREKSI INI<--- PASTIKAN INI ADA DAN PATHNYA BENAR

// // Import ini juga perlu dikoreksi agar mengarah ke file HomeScreen1 yang sudah kita buat
// // import 'package:ppkd_b2/tugas_15/view/home_screen.dart'; // <<< Import loginScreenApi <--- SALAH. HARUSNYA HOME SCREEN.
// import 'package:ppkd_b2/tugas_15/view/home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   static const String id = "/splash_screen"; // Tambahkan ID untuk rute

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _glowAnimationController;
//   late Animation<double> _glowScaleAnimation;
//   late Animation<double> _glowOpacityAnimation;

//   late AnimationController _logoAnimationController;
//   late Animation<double> _logoOpacityAnimation;
//   late Animation<double> _logoScaleAnimation;

//   final UserService _userService = UserService(); // Instansiasi UserService

//   @override
//   void initState() {
//     super.initState();

//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     _glowAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _glowScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _glowAnimationController, curve: Curves.easeOut),
//     );
//     _glowOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _glowAnimationController,
//         curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
//       ),
//     );

//     _logoAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//     _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
//     );
//     _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoAnimationController,
//         curve: Curves.easeOutBack,
//       ),
//     );

//     // Urutan Animasi
//     _glowAnimationController.forward().then((_) {
//       Future.delayed(const Duration(milliseconds: 200), () {
//         _logoAnimationController.forward().then((_) {
//           // Panggil fungsi pengecekan login setelah semua animasi selesai
//           _checkLoginStatusAndNavigate();
//         });
//       });
//     });
//   }

//   Future<void> _checkLoginStatusAndNavigate() async {
//     // Beri sedikit jeda tambahan setelah animasi jika diperlukan sebelum navigasi
//     await Future.delayed(const Duration(milliseconds: 500));

//     final String? token = await _userService.checkLoginStatus();

//     if (!mounted) return;

//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.edgeToEdge,
//     ); // Kembalikan UI bar

//     if (token != null) {
//       // Jika ada token (sudah login), arahkan ke home screen
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const HomeScreen1()),
//       ); // Menggunakan HomeScreen1.id
//     } else {
//       // Jika tidak ada token (belum login), arahkan ke login screen
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const loginScreenApi()),
//       ); // Menggunakan loginScreenApi.id
//     }
//   }

//   @override
//   void dispose() {
//     _glowAnimationController.dispose();
//     _logoAnimationController.dispose();
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.edgeToEdge,
//     ); // Pastikan UI bar dikembalikan
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Center(
//             child: AnimatedBuilder(
//               animation: _glowAnimationController,
//               builder: (context, child) {
//                 return Opacity(
//                   opacity: _glowOpacityAnimation.value,
//                   child: Transform.scale(
//                     scale: _glowScaleAnimation.value * 2.0,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.amber.withOpacity(0.7),
//                             blurRadius: 50.0,
//                             spreadRadius: 20.0,
//                           ),
//                           BoxShadow(
//                             color: Colors.yellow.withOpacity(0.5),
//                             blurRadius: 30.0,
//                             spreadRadius: 10.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Center(
//             child: FadeTransition(
//               opacity: _logoOpacityAnimation,
//               child: ScaleTransition(
//                 scale: _logoScaleAnimation,
//                 child: Image.asset(
//                   'assets/images/pter.png', // Path ke foto teks Harry Potter
//                   width: 300,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
