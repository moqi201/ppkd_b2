import 'package:flutter/material.dart';

class MeetEmpatB extends StatefulWidget {
  const MeetEmpatB({super.key});

  @override
  State<MeetEmpatB> createState() => _MeetEmpatBState();
}

class _MeetEmpatBState extends State<MeetEmpatB> {
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet 4B", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff537D5D),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Text("TextFIeld"),
            TextField(
              decoration: InputDecoration(
                hintText: "Masukkan Nama",
                hintStyle: TextStyle(fontSize: 12),
                filled: true,
                fillColor: Color(0xffD2D0A0),
                suffixIcon: Icon(Icons.visibility),
                border: OutlineInputBorder(
                  //Border awal
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffD2D0A0), width: 1),
                  // borderSide: BorderSide(color: Colors.black, width: 5),
                ),
                focusedBorder: OutlineInputBorder(
                  // BOrder Ketika di klik
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  // borderSide: BorderSide(color: Colors.black, width: 5),
                ),
                // border
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              // readOnly: true,
              onChanged: (value) {
                print(value);
                setState(() {
                  passwordController.text = value;
                });
              },
              onSubmitted: (value) {
                print(value);
              },
              // style: TextStyle(fontSize: 20),// Untuk mengatur ukuran textfield
              textAlign: TextAlign.center, // Untuk mengatur posisi textfield
              // maxLines: 4,// Untuk mengatur tinggi textfield
              // maxLength: 5,// Untuk mengatur panjang textfield
              // keyboardType: TextInputType.number, // Untuk mengatur keyboard yang muncul
              obscureText: true,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                hintText: "Masukkan Email",
                // hintStyle: TextStyle(fontSize: 12),
                filled: true,
                fillColor: Color(0xffD2D0A0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffD2D0A0), width: 1),
                  // borderSide: BorderSide(color: Colors.black, width: 5),
                ),
                prefixIcon: Icon(Icons.email), // Icon di depan
                // border
              ),
            ),
            SizedBox(height: 50),
            Text(passwordController.text),
          ],
        ),
      ),
    );
  }
}