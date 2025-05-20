import 'package:flutter/material.dart';

class MeetDua extends StatelessWidget {
  const MeetDua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Lengkap'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 254, 166, 230),
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris 1: Foto Profil + Nama (dengan BoxDecoration)
 Center(
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Column(
      children: [
        // Gambar Profil dengan BoxDecoration
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/masita.jpg'),
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Nikita Aidina Hidyat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 185, 215, 255),
          ),
        ),
      ],
    ),
  ),
),


          // Baris 2: Email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 184, 253),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.email, color: Color.fromARGB(255, 255, 255, 255)),
                  SizedBox(width: 8),
                  Text("niki@email.com"),
                ],
              ),
            ),
          ),

          // Baris 3: Nomor HP
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Row(
              children: const [
                Icon(Icons.phone_android, color: Color.fromARGB(255, 0, 0, 0)),
                SizedBox(width: 8),
                Text("0895-1243-4810"),
                Spacer(),
              ],
            ),
          ),

          // Baris 4: Postingan & Followers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 23, 240, 255),
                    ),
                    child: const Center(child: Text("Postingan")),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 255, 184, 253),
                    ),
                    child: const Center(child: Text("Followers")),
                  ),
                ),
              ],
            ),
          ),

          // Baris 5: Deskripsi Profil
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Penulis dan musisi yang mencintai dunia sastra dan seni. "
              "Bekerja di berbagai proyek kreatif dan aktif membagikan pemikiran melalui karya.",
              style: TextStyle( fontFamily: 'Montserrat',color: Colors.black),
              textAlign: TextAlign.justify,

            ),
          ),

          // Baris 6: Hiasan Visual
          const SizedBox(height: 20),
          Container(
            height: 60,
            color: const Color.fromARGB(255, 255, 0, 0),
            child: Center(
              child: Text(
                "Terima kasih telah mengunjungi profil saya!",
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
