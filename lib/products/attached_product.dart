import 'package:cost_calculator/products/product.dart';

class AttachedProduct {
  double quantity;
  Product product;

  AttachedProduct({
    required this.quantity,
    required this.product,
  });

  factory AttachedProduct.fromJson(Map<String, dynamic> json) {
    return AttachedProduct(
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  double get price => quantity * product.price;

  double get unitPrice => price / quantity;

  String label(String symbol) {
    return '$symbol$unitPrice x$quantity u = $symbol$price';
  }
}