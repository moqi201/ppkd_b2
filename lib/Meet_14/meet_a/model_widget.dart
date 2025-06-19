import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_14/meet_a/model/product_model.dart';
import 'package:ppkd_b2/constant/App_image.dart';


class ModelWidget extends StatefulWidget {
  const ModelWidget({super.key});

  @override
  State<ModelWidget> createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget> {
  final List<ProductModel> dataProduct = [
    ProductModel(
      id: "1",
      productName: "Apple",
      productPrice: "50000",
      productImage: AppImage.apple,
    ),
    ProductModel(
      id: "2",
      productName: "Anggur",
      productPrice: "25000",
      productImage: AppImage.anggur,
    ),
    ProductModel(
      id: "3",
      productName: "Pisang",
      productPrice: "150000",
      productImage: AppImage.pisang,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Model")),
      body: ListView.builder(
        itemCount: dataProduct.length,
        itemBuilder: (BuildContext context, int index) {
          final product = dataProduct[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(product.productImage ?? ""),
            ),
            title: Text(product.productName ?? ""),
            subtitle: Text("Rp. ${product.productPrice}" ?? ""),
          );
        },
      ),
    );
  }
}
