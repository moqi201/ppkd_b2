import 'dart:io';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../model/model_hewan.dart';
import 'hewan_detail.dart';
import 'hewan_form.dart';
import 'hewan_edit.dart';

class HewanListScreen extends StatefulWidget {
  const HewanListScreen({super.key});

  @override
  State<HewanListScreen> createState() => _HewanListScreenState();
}

class _HewanListScreenState extends State<HewanListScreen> {
  List<ModelHewan> daftarHewan = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await DbHelper.getAllHewan();
    setState(() {
      daftarHewan = data;
    });
  }

  Future<void> deleteData(int id) async {
    await DbHelper.deleteHewan(id);
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Icon(Icons.pets,size: 40, color: Colors.white,),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: daftarHewan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data 🐾',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: daftarHewan.length,
              itemBuilder: (context, index) {
                final hewan = daftarHewan[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: hewan.foto.isNotEmpty &&
                              File(hewan.foto).existsSync()
                          ? Image.file(
                              File(hewan.foto),
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 56,
                              height: 56,
                              color: Colors.teal.shade100,
                              child: const Icon(Icons.pets, color: Colors.teal),
                            ),
                    ),
                    title: Text(
                      hewan.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${hewan.jenis} • ${hewan.umur} th • ${hewan.berat} kg',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HewanEditScreen(hewan: hewan),
                              ),
                            );
                            if (result == true) loadData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () {
                            deleteData(hewan.id!);
                          },
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HewanDetailScreen(hewan: hewan),
                        ),
                      );
                      await loadData();
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HewanFormScreen()),
          );
          if (result == true) loadData();
        },
        child: const Icon(Icons.pets, size: 30, color: Colors.white,),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
