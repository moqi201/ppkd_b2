import 'package:flutter/material.dart';

class HouseSlider extends StatelessWidget {
  final Function(String) onHouseSelected;

  const HouseSlider({super.key, required this.onHouseSelected});

  final List<Map<String, String>> houses = const [
    {"name": "Gryffindor", "image": "assets/houses/gryffindor.png"},
    {"name": "Hufflepuff", "image": "assets/houses/hufflepuff.png"},
    {"name": "Ravenclaw", "image": "assets/houses/ravenclaw.png"},
    {"name": "Slytherin", "image": "assets/houses/slytherin.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: houses.length,
        itemBuilder: (context, index) {
          final house = houses[index];
          return GestureDetector(
            onTap: () => onHouseSelected(house['name']!),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(house['image']!),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    house['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
