import 'package:flutter/material.dart';
import 'package:ppkd_b2/study_kasus/database/db_helper2.dart';
import 'package:ppkd_b2/study_kasus/model/model_peserta.dart';

class PesertaApp extends StatefulWidget {
  const PesertaApp({super.key});

  @override
  State<PesertaApp> createState() => _PesertaAppState();
}

class _PesertaAppState extends State<PesertaApp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final List<Map<String, String>> daftarPeserta = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DbHelper2 dbHelper = DbHelper2();
  @override
  void initState() {
    super.initState();
    muatData();
  }
  Future<void> muatData() async {
    final data = await dbHelper.getAllPeserta();
    setState(() {
      daftarPeserta.clear();
      daftarPeserta.addAll(
        data.map((peserta) => {
          'name': peserta.name,
          'email': peserta.email,
          'event': peserta.event,
          'kota': peserta.kota,
        }),
      );
    });
  }
  Future<void> simpanData() async {
    if (_formKey.currentState?.validate() ?? false) {
      final peserta = Peserta(
        name: nameController.text,
        email: emailController.text,
        event: eventController.text,
        kota: kotaController.text,
      );
      await dbHelper.insertPeserta(peserta);
      nameController.clear();
      emailController.clear();
      eventController.clear();
      kotaController.clear();
      muatData();
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pendaftaran Peserta')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Peserta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email Peserta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: eventController,
                decoration: InputDecoration(labelText: 'Event'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Event tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: kotaController,
                decoration: InputDecoration(labelText: 'Kota'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kota tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: simpanData,
                child: Text('Simpan Peserta'),
              ),
              Divider(height: 40, thickness: 2),
              Expanded(child:
                ListView.builder(
                  itemCount: daftarPeserta.length,
                  itemBuilder: (context, index) {
                    final peserta = daftarPeserta[index];
                    return ListTile(
                      title: Text(peserta['name'] ?? 'No Name'),
                      subtitle: Text(
                        'Email: ${peserta['email']}\nEvent: ${peserta['event']}\nKota: ${peserta['kota']}',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}