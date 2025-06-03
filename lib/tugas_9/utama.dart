import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_9/Tugas9.dart';
import 'package:ppkd_b2/tugas_9/Tugas9a.dart';
import 'package:ppkd_b2/tugas_9/Tugas9b.dart';

class Utama extends StatelessWidget {
  const Utama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Title
              const Text(
                'Data Display Options',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 32),
              
              // List Button
              _buildMenuButton(
                context: context,
                title: 'List View',
                icon: Icons.list_alt,
                destination: const List1(),
              ),
              
              const SizedBox(height: 16),
              
              // Map Button
              _buildMenuButton(
                context: context,
                title: 'Map View',
                icon: Icons.map_outlined,
                destination: const ListMap(),
              ),
              
              const SizedBox(height: 16),
              
              // Combined Button
              _buildMenuButton(
                context: context,
                title: 'Combined View',
                icon: Icons.view_agenda_outlined,
                destination: const Model(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget destination,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple[600],
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: Colors.deepPurple.withOpacity(0.3),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}