// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profil Saya',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto',
//       ),
//       home: ProfilPage(),
//     );
//   }
// }

// class ProfilPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profil Saya'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Baris 1: Nama lengkap
//             Text(
//               'NIKITA',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 10),

//             // Baris 2: Lokasi
//             Row(
//               children: [
//                 Icon(
//                   Icons.location_on,
//                   color: Colors.redAccent,
//                 ),
//                 SizedBox(width: 4),
//                 Text(
//                   'SUDIRMAN',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),

//             // Baris 3: Deskripsi singkat
//             Text(
//               'SAYA ADALAH BETMEN.',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//               textAlign: TextAlign.justify,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }