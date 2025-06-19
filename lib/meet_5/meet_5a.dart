import 'package:flutter/material.dart';

class MeetLima extends StatefulWidget {
  const MeetLima({super.key});

  @override
  State<MeetLima> createState() => _MeetLimaState();
}

class _MeetLimaState extends State<MeetLima> {
  int nilaiTambah = 0;
  bool tampilkanLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet 5", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff537D5D),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("tekan disni");
          setState(() {
            nilaiTambah++;
          });
          print(nilaiTambah);
        },
      ),
      body: Column(
        children: [
          //Elevated Button
          buildElevatedButton(),
          //Icon Button
          buildIconButton(),
          //Text Button
          buildTextButton(),
          //Inkwell
          buildInkWell(),
          GestureDetector(
            onLongPress: () {
              print("tekan lama");
              setState(() {
                nilaiTambah--;
              });
            },
            onDoubleTap: () {
              print("tekan dua kali");
              setState(() {
                nilaiTambah = 0;
              });
            },
            onTap: () {
              print("Saya tekan disini");
              setState(() {
                nilaiTambah++;
              });
              print(nilaiTambah);
            },
            child: Container(
              height: 200,
              width: 200,
              color: Colors.red,
              child: Center(
                child: Text(
                  "Ini adalah Container",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildInkWell() {
    return InkWell(
      splashColor: Colors.red,
      onTap: () {
        print("tekan sekali");
        setState(() {
          nilaiTambah++;
        });
      },
      onLongPress: () {
        print("tekan lama");
        setState(() {
          nilaiTambah--;
        });
      },
      onDoubleTap: () {
        print("tekan dua kali");
        setState(() {
          nilaiTambah = 0;
        });
      },
      child: Image.asset("assets/images/jokowi.jpg", width: 200, height: 200),
    );
  }

  Column buildTextButton() {
    return Column(
      children: [
        tampilkanLoading ? CircularProgressIndicator() : SizedBox(),
        //Text Button
        TextButton(
          onPressed: () {
            setState(() {
              tampilkanLoading = !tampilkanLoading;
            });
            print(tampilkanLoading);
          },
          child: Text("Tampilkan Loading"),
        ),
      ],
    );
  }

  Column buildIconButton() {
    return Column(
      children: [
        nilaiWidget(),
        IconButton(
          onPressed: () {
            print("Saya tekan disini");
            setState(() {
              nilaiTambah--;
            });
            print(nilaiTambah);
          },
          icon: Icon(Icons.minimize),
        ),
      ],
    );
  }

  Column buildElevatedButton() {
    return Column(
      children: [
        nilaiWidget(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  print("Saya tekan disini");
                  setState(() {
                    nilaiTambah++;
                  });
                  print(nilaiTambah);
                },
                child: Text("Tambah", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text nilaiWidget() {
    return Text(
      nilaiTambah.toString(),
      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
    );
  }
}