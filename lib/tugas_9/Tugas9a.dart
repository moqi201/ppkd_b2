import 'package:flutter/material.dart';

class ListMap extends StatefulWidget {
  const ListMap({super.key});

  @override
  State<ListMap> createState() => _ListMapState();
}

class _ListMapState extends State<ListMap> {
  final List<Map<String, dynamic>> kategori = [
    {'nama': 'Buah-buahan', 'icon': Icons.apple},
    {'nama': 'Sayuran', 'icon': Icons.eco},
    {'nama': 'Elektronik', 'icon': Icons.devices},
    {'nama': 'Pakaian Pria', 'icon': Icons.man},
    {'nama': 'Pakaian Wanita', 'icon': Icons.woman},
    {'nama': 'Alat Tulis Kantor', 'icon': Icons.edit_note},
    {'nama': 'Buku & Majalah', 'icon': Icons.menu_book},
    {'nama': 'Peralatan Dapur', 'icon': Icons.kitchen},
    {'nama': 'Makanan Ringan', 'icon': Icons.cookie},
    {'nama': 'Minuman', 'icon': Icons.local_drink},
    {'nama': 'Mainan Anak', 'icon': Icons.toys},
    {'nama': 'Peralatan Olahraga', 'icon': Icons.sports_soccer},
    {'nama': 'Produk Kesehatan', 'icon': Icons.medical_services},
    {'nama': 'Kosmetik', 'icon': Icons.spa},
    {'nama': 'Obat-obatan', 'icon': Icons.medication},
    {'nama': 'Aksesoris Mobil', 'icon': Icons.directions_car},
    {'nama': 'Perabot Rumah', 'icon': Icons.chair},
    {'nama': 'Sepatu & Sandal', 'icon': Icons.shopping_bag},
    {'nama': 'Barang Bekas', 'icon': Icons.recycling},
    {'nama': 'Voucher & Tiket', 'icon': Icons.confirmation_number},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.grey[50],
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: kategori.length,
          separatorBuilder:
              (context, index) =>
                  const Divider(height: 1, thickness: 1, color: Colors.black12),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    child: Icon(
                      kategori[index]['icon'],
                      color: Colors.deepPurple,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    kategori[index]['nama'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    // Add navigation or action here
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
