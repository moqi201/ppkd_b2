import 'package:flutter/material.dart';
import 'package:ppkd_b2/study%20case/database/db_helper1.dart';
import 'package:ppkd_b2/study%20case/model/model_siswa.dart';

class SiswaApp extends StatefulWidget {
  const SiswaApp({super.key});

  @override
  State<SiswaApp> createState() => _SiswaAppState();
}

class _SiswaAppState extends State<SiswaApp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final List<Siswa> daftarSiswa = [];
  final DbHelper1 dbHelper = DbHelper1();
  // final _formKey = GlobalKey<FormState>(); // Uncomment and use in your Form if needed

  @override
  void initState() {
    super.initState();
    muatData();
    // Initialize any necessary data or state here
  }

  Future<void> muatData() async {
    final data = await dbHelper.getAllSiswa();
    setState(() {
      daftarSiswa.clear();
      daftarSiswa.addAll(data);
    });
  }

  Future<void> simpanData() async {
    final nama = nameController.text;
    final umur = int.tryParse(umurController.text) ?? 0;
    if (nama.isNotEmpty && umur > 0) {
      final siswa = Siswa(name: nama, umur: umur);
      await dbHelper.insertSiswa(siswa);
      nameController.clear();
      umurController.clear();
      muatData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pendaftaran Siswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Siswa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: umurController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Umur Siswa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: simpanData, child: Text('Simpan Data')),
            Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: daftarSiswa.length,
                itemBuilder: (BuildContext context, int index) {
                  final siswa = daftarSiswa[index];
                  return ListTile(
                    title: Text(siswa.name),
                    subtitle: Text('Umur: ${siswa.umur}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await dbHelper.deleteSiswa(siswa.id!);
                        muatData();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
