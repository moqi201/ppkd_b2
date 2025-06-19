import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_14/meet_a/list_in_map_widget.dart';
import 'package:ppkd_b2/Meet_14/meet_a/list_widget.dart';
import 'package:ppkd_b2/Meet_14/meet_a/map_widget.dart';
import 'package:ppkd_b2/Meet_14/meet_a/model_widget.dart';
class Meet14a extends StatelessWidget {
  const Meet14a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListWidget()),
                  );
                },
                child: Text("List"),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapWidget()),
              );
            },
            child: Text("Map"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListInMapWidget()),
              );
            },
            child: Text("List and Map"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModelWidget()),
              );
            },
            child: Text("Model"),
          ),
        ],
      ),
    );
  }
}
