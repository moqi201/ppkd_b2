import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final List<String> namaBuah = [
    "Apel",
    "Jeruk",
    "Mangga",
    "Pisang",
    "Semangka",
    "Anggur",
    "Nanas",
    "Melon",
    "Kiwi",
    "Strawberry",
    "Blueberry",
  ];

  final List<String> namaMerekHp = [
    "Samsung",
    "Apple",
    "Xiaomi",
    "Oppo",
    "Vivo",
    "Realme",
    "Huawei",
    "Nokia",
    "Sony",
    "LG",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: namaBuah.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  "${index + 1} ${namaBuah[index]}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: namaMerekHp.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  "${index + 1} ${namaMerekHp[index]}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
