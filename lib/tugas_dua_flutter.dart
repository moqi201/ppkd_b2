import 'package:flutter/material.dart';

class MeetDua extends StatelessWidget {
  const MeetDua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 241, 241),
      appBar: AppBar(
        title: const Text(
          'Profil Lengkap',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'NanumGothic',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// Bagian Foto Profil & Nama
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.pinkAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/masita.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nikita Aidina Hidyat',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "@nikita_hidyat",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Kartu Informasi Kontak
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.pinkAccent),
                          SizedBox(width: 12),
                          Text("niki@email.com"),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.pinkAccent),
                          SizedBox(width: 12),
                          Text("0895-1243-4810"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Postingan dan Followers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "125",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Postingan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "8.2K",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Followers",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Deskripsi Profil dengan Spacer
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Spacer(flex: 1),
                Expanded(
                  flex: 8,
                  child: Text(
                    "Penulis dan musisi yang mencintai dunia sastra dan seni. "
                    "Bekerja di berbagai proyek kreatif dan aktif membagikan pemikiran melalui karya."
                    "saya asli org betawi",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),

            const SizedBox(height: 30),

            /// Footer (hiasan visual)
            // Container(
            //   width: double.infinity,
            //   height: 60,
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     color: Colors.pinkAccent.shade100,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: const Center(
            //     child: Text(
            //       "Terima kasih telah mengunjungi profil saya!",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
