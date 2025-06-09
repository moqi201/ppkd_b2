import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_13/CRUD/form_siswa.dart';
import 'package:ppkd_b2/tugas_13/CRUD/edit_siswa.dart';
import 'package:ppkd_b2/tugas_13/model/model_siswa.dart';
import 'package:ppkd_b2/tugas_13/database/db_helper.dart';

class DashboardSiswa extends StatefulWidget {
  static const String id = "/dashboard";
  const DashboardSiswa({Key? key}) : super(key: key);

  @override
  State<DashboardSiswa> createState() => _DashboardSiswaState();
}

class _DashboardSiswaState extends State<DashboardSiswa> {
  final DbHelper1 _dbHelper = DbHelper1();
  List<Siswa> _siswaList = [];
  int _total = 0;

  void _loadData() async {
    final siswa = await _dbHelper.getAllSiswa();
    final total = await _dbHelper.getTotalSiswa();
    setState(() {
      _siswaList = siswa;
      _total = total;
    });
  }

  void _delete(int id) async {
    await _dbHelper.deleteSiswa(id);
    _loadData();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Siswa")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Siswa", style: TextStyle(fontSize: 18)),
                Text("$_total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _siswaList.length,
              itemBuilder: (context, index) {
                final siswa = _siswaList[index];
                return ListTile(
                  leading: Image.asset(siswa.imagePath, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(siswa.nama),
                  subtitle: Text(siswa.kelas),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditSiswa(siswa: siswa)),
                          );
                          if (result == true) _loadData();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _delete(siswa.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahSiswa()),
          );
          if (result == true) _loadData();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
