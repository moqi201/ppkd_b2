// Screen/list_siswa.dart
import 'package:flutter/material.dart';
import 'package:ppkd_b2/tugas_13/database/db_helper.dart';
import 'package:ppkd_b2/tugas_13/model/model_siswa.dart';
import 'package:ppkd_b2/tugas_13/screen/dashboard_siswa.dart';
import 'package:ppkd_b2/tugas_13/screen/list_sekolah.dart';


class ListSiswaScreen extends StatefulWidget {
  static const String id ="/list_siswa";
  const ListSiswaScreen({Key? key}) : super(key: key);

  @override
  State<ListSiswaScreen> createState() => _ListSiswaScreenState();
}

class _ListSiswaScreenState extends State<ListSiswaScreen> {
  final DbHelper1 _dbHelper = DbHelper1();
  List<Siswa> _siswaList = [];
  List<Siswa> _filtered = [];
  TextEditingController _searchController = TextEditingController();

  void _loadSiswa() async {
    final data = await _dbHelper.getAllSiswa();
    setState(() {
      _siswaList = data;
      _filtered = data;
    });
  }

  void _filterSearch(String query) {
    final filtered = _siswaList.where((siswa) =>
        siswa.nama.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      _filtered = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSiswa();
    _searchController.addListener(() {
      _filterSearch(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Siswa'),
      ),
      endDrawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          'Menu Navigasi',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {
          Navigator.pushNamed(context, DashboardSiswa.id);
        },
      ),
      ListTile(
        leading: const Icon(Icons.list),
        title: const Text('Data Siswa'),
        onTap: () {
          Navigator.pop(context); /// semeentaraa sebelum ada login
        },
      ),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text('Tentang Sekolah'),
        onTap: () {
          Navigator.pushNamed(context, TentangSekolahScreen.id);
        },
      ),
    ],
  ),
),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Cari Nama Siswa",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final siswa = _filtered[index];
                return ListTile(
                  leading: Image.asset(siswa.imagePath, width: 50, height: 50),
                  title: Text(siswa.nama),
                  subtitle: Text('${siswa.kelas} - ${siswa.email}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
