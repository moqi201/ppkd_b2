import 'package:flutter/material.dart';

class meetSatu extends StatelessWidget {
  const meetSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey, // Changed color to indigoAccent
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
      drawer: Drawer(),
      backgroundColor: Colors.grey[100], // Changed background color to white
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {}, 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("pertemuan 1"),
          Text("makna"),
          Text("colum dsatu"),
          Text("column dua"),
          Text("column tga"),
          Text("column empt"),
          Text("column lma"),
          Text("😒"),
          Row(
            children: [
              Text("pertemuan 1"),
          Text("makna"),
          Text("colum dsatu"),
          Text("column dua"),
          Text("column tga"),
          Text("column empt"),
          ],
          )
        ],
      ) ,
    );
  }
}