import 'package:flutter/material.dart';
import 'package:ppkd_b2/constant/App_image.dart';
import 'package:ppkd_b2/tugas_9/model.dart';

class Model extends StatefulWidget {
  const Model({super.key});

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  final List<ProductModell> dataProduct = [
    ProductModell(
      id: "1",
      productName: "Obat sakit kepala",
      productPrice: "50000",
      productImage: AppImage.obat3,
    ),
    ProductModell(
      id: "2",
      productName: "Obat Sakit Gigi",
      productPrice: "25000",
      productImage: AppImage.obat2,
    ),
    ProductModell(
      id: "3",
      productName: "Obat Mata Merah",
      productPrice: "150000",
      productImage: AppImage.obat4,
    ),
    ProductModell(
      id: "4",
      productName: "Obat cina",
      productPrice: "150000",
      productImage: AppImage.obat1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medicine Products",
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
          itemCount: dataProduct.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (BuildContext context, int index) {
            final product = dataProduct[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(product.productImage ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  product.productName ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      "Rp. ${product.productPrice}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.deepPurple,
                  ),
                ),
                onTap: () {
                  // Add product detail navigation here
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
