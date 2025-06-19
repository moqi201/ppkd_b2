import 'package:flutter/material.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Map<String, dynamic> data = {
    'nama': 'Budi',
    'umur': 25,
    'alamat': 'Jakarta',
  };

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> dataUser = data.entries.toList();
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: dataUser.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(dataUser[index].key),
            subtitle: Text(dataUser[index].value.toString()),
          );
        },
      ),
    );
  }
}
