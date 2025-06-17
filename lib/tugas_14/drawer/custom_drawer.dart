// widgets/custom_drawer.dart
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final void Function(String) onTap;

  const CustomDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Hogwarts Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('List Semua'),
            onTap: () => onTap('all'),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Hogwarts Student'),
            onTap: () => onTap('student'),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Hogwarts Staff'),
            onTap: () => onTap('staff'),
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Spesies'),
            onTap: () => onTap('species'),
          ),
        ],
      ),
    );
  }
}
