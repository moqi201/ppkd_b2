import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ppkd_b2/study_2/database/db_helper3.dart';
import 'package:ppkd_b2/study_2/model/model_hewan.dart';
import 'package:ppkd_b2/study_2/screens/hewan_detail.dart';
import 'package:ppkd_b2/study_2/screens/hewan_update.dart';
// import 'hewan_detail_screen.dart';

class HewanListScreen extends StatefulWidget {
  const HewanListScreen({super.key});

  @override
  State<HewanListScreen> createState() => _HewanListScreenState();
}

class _HewanListScreenState extends State<HewanListScreen> {
  final DbHelper3 dbHelper = DbHelper3();
  List<ModelHewan> daftarHewan = [];

  @override
  void initState() {
    super.initState();
    muatData();
  }

  Future<void> muatData() async {
    final data = await dbHelper.getAllHewan();
    setState(() {
      daftarHewan = data;
    });
  }

  Future<void> hapusData(int id) async {
    await dbHelper.deleteHewan(id);
    await muatData();
  }

  Future<void> updateData(int id) async {
    await dbHelper.updateHewan(id);
    await muatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.pets, size: 30, color: Colors.white),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            daftarHewan.isEmpty
                ? const Center(child: Text('Belum ada data.'))
                : GridView.builder(
                  itemCount: daftarHewan.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final hewan = daftarHewan[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  hewan.foto.isNotEmpty
                                      ? Image.memory(
                                        base64Decode(hewan.foto),
                                        width: double.infinity,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                      : const Icon(Icons.pets, size: 100),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hewan.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(hewan.jenis),
                            Text('${hewan.umur} th | ${hewan.berat} kg'),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => hapusData(hewan.id),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                HewanDetailScreen(hewan: hewan),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.teal,
                                    size: 20,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HewanUpdate(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.update,
                                    color: Colors.teal,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          final reload = await Navigator.pushNamed(context, '/hewan_form');
          if (reload == true) {
            muatData();
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
