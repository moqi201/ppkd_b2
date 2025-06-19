import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_14/meet_a/list_widget.dart';
import 'package:ppkd_b2/Meet_14/meet_a/map_widget.dart';
import 'package:ppkd_b2/constant/App_Style.dart';


class ListInMapWidget extends StatefulWidget {
  const ListInMapWidget({super.key});

  @override
  State<ListInMapWidget> createState() => _ListInMapWidgetState();
}

class _ListInMapWidgetState extends State<ListInMapWidget> {
  final List<Map<String, dynamic>> dataUser = [
    {
      'nama': 'Budi',
      'umur': 25,
      'alamat': 'Jakarta',
      "icon": Icons.apple,
      'route': ListWidget(),
    },
    {
      'nama': 'Siti',
      'umur': 30,
      'alamat': 'Bandung',
      "icon": Icons.balance,
      'route': MapWidget(),
    },
    {
      'nama': 'Andi',
      'umur': 22,
      'alamat': 'Surabaya',
      "icon": Icons.safety_check,
    },
    {
      'nama': 'Dewi',
      'umur': 28,
      'alamat': 'Yogyakarta',
      "icon": Icons.dangerous,
    },
    {'nama': 'Joko', 'umur': 35, 'alamat': 'Medan', "icon": Icons.face},
    {'nama': 'Rina', 'umur': 27, 'alamat': 'Bali', "icon": Icons.g_mobiledata},
    {
      'nama': 'Tono',
      'umur': 20,
      'alamat': 'Makassar',
      "icon": Icons.h_mobiledata,
    },
    {
      'nama': 'Lina',
      'umur': 32,
      'alamat': 'Palembang',
      "icon": Icons.javascript,
    },
    {'nama': 'Eko', 'umur': 29, 'alamat': 'Semarang', "icon": Icons.apple},
    {'nama': 'Sari', 'umur': 24, 'alamat': 'Malang', "icon": Icons.apple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List in Map")),
      body: ListView.builder(
        itemCount: dataUser.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
              "${index + 1}",
              style: AppStyle.fontBold(fontSize: 18),
            ),
            title: Text(
              "${dataUser[index]["nama"]}, ${dataUser[index]['alamat']}",
            ),
            subtitle: Text("Umur : ${dataUser[index]["umur"]}"),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dataUser[index]["route"],
                  ),
                );
              },
              icon: Icon(dataUser[index]["icon"], color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
