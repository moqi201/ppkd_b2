import 'package:flutter/material.dart';

class meetSatu extends StatelessWidget {
  const meetSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent, // Changed color to indigoAccent
        title: Text("Pertemuan 1"), // Changed title to "Pertemuan 1"
        centerTitle: true, // Centered the title
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Action for search button
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text("Pertemuan 1", style: TextStyle(fontSize: 35)),
            Text("PPKD B 2"),
            Text("Kelas Mobile Programming"),
            Text("Nama Toko"),
            Row(children: [Text("Gambar 1")]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text("Gambar 2")],
            ),
            Text("Gambar 3"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("Gambar 4")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Gambar 5")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text("Gambar 6")],
            ),
            Text("Gambar 7"),
            Row(
              children: [
                Text("Gambar 1"),
                Text("Gambar 2"),
                Text("Gambar 3"),
                Text("Gambar 4"),
                Text("Gambar 5"),
                Text("Gambar 6"),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100], // Changed background color to white
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
          child: Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Gambar 2")],
          ),
          Text("Gambar 3"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Gambar 4")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Gambar 5")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Gambar 6")],
          ),
          Row(
            children: [
              Text("Gambar 1"),
              Text("Gambar 2"),
              Text("Gambar 3"),
              Text("Gambar 4"),
              Text("Gambar 5"),
              Text("Gambar 6"),
            ],
          ),
        ],
      ),
    );
  }
}