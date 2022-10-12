import 'package:cost_calculator/materials/material.dart';
import 'package:cost_calculator/materials/mearure.dart';

class AttachedMaterial {
  double quantity;
  Material material;

  AttachedMaterial({
    required this.quantity,
    required this.material,
  });

  factory AttachedMaterial.fromJson(Map<String, dynamic> json) {
    return AttachedMaterial(
      quantity: json['quantity'],
      material: Material.fromJson(json['material']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'material': material.toJson(),
    };
  }

  double get price => quantity * material.unitPrice;

  double get unitPrice => price / quantity;

  String label(String symbol){
    return '$symbol$unitPrice x$quantity ${measureAbbr(material.measure)} = $symbol$price';
  }

}