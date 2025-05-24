import 'package:flutter/material.dart';

class Latihan extends StatefulWidget {
  const Latihan({super.key});

  @override
  State<Latihan> createState() => _LatihanState();
}

class _LatihanState extends State<Latihan> {
  String namaText = '';
  bool isLiked = false;
  String deskripsi = '';
  int counter = 0;
  bool showInkWellText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // biar kontras
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 4,
            title: const Text(
              "Modern Aesthetic",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFC5C7D),
                    Color(0xFF6A82FB),
                    Colors.blue,
                    Color(0xFFFC5C7D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Nama Section
            if (namaText.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDEDEC),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/masita.jpg'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      namaText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                  ],
                ),
              ),

            // Tampilkan Nama Button
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    namaText = namaText.isEmpty ? 'Nikita' : '';
                  });
                },
                child: const Text(
                  'Tampilkan Nama',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // InkWell Section (Centered)
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    showInkWellText = !showInkWellText;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color:
                        showInkWellText
                            ? const Color(0xFF00B894)
                            : const Color(0xFF0984E3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (showInkWellText
                                ? const Color(0xFF00B894)
                                : const Color(0xFF0984E3))
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                        showInkWellText
                            ? const Text(
                              'DI TEKAN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : const Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: 40,
                            ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Like and Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? const Color(0xFFE84393) : Colors.grey[400],
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),

            if (isLiked)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Disukai',
                  style: TextStyle(
                    color: const Color(0xFFE84393),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Deskripsi Section
            TextButton(
              onPressed: () {
                setState(() {
                  deskripsi =
                      deskripsi.isEmpty
                          ? "Saya adalah seorang profesional di bidang teknologi dengan pengalaman dalam pengembangan aplikasi mobile menggunakan Flutter. Memiliki kemampuan problem solving yang baik, kreatif dalam mencari solusi, serta selalu bersemangat untuk belajar hal-hal baru dan beradaptasi dengan teknologi terkini. Saya berkomitmen untuk memberikan hasil kerja berkualitas tinggi dan berkontribusi secara positif dalam tim."
                          : '';
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFDFE6E9).withOpacity(0.5),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: const Color(0xFF6C5CE7).withOpacity(0.3),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.description, color: Color(0xFF6C5CE7), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Tampilkan Deskripsi',
                    style: TextStyle(color: Color(0xFF2D3436), fontSize: 16),
                  ),
                ],
              ),
            ),

            if (deskripsi.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDCB6E).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFFDCB6E).withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Color(0xFFE17055),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          deskripsi,
                          style: const TextStyle(
                            color: Color(0xFF2D3436),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Gesture Detector Section
            GestureDetector(
              onTap: () => print("Ditekan sekali"),
              onDoubleTap: () => print("Di tekan dua kali"),
              onLongPress: () => print("Di tekan lama"),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA8E063), Color(0xFF56AB2F)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        121,
                        122,
                        120,
                      ).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "Tekan Aku",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Counter Section
            Text(
              'Counter: $counter',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C5CE7),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },

        backgroundColor: const Color(0xFF6C5CE7),
        elevation: 5,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
