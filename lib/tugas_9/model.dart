import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModell {
  final String id;
  final String? productName;
  final String? productPrice;
  final String? productImage;
  ProductModell({
    required this.id,
    this.productName,
    this.productPrice,
    this.productImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,
    };
  }

  factory ProductModell.fromMap(Map<String, dynamic> map) {
    return ProductModell(
      id: map['id'] as String,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      productPrice:
          map['productPrice'] != null ? map['productPrice'] as String : null,
      productImage:
          map['productImage'] != null ? map['productImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModell.fromJson(String source) =>
      ProductModell.fromMap(json.decode(source) as Map<String, dynamic>);
}
