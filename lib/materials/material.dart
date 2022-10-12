
import 'package:cost_calculator/materials/mearure.dart';

class Material {
  String uuid;
  String name;
  double price;
  double quantity;
  Measure measure;
  
  Material({
    required this.uuid,
    required this.name,
    required this.price,
    required this.quantity,
    required this.measure
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      uuid: json['uuid'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      measure: Measure.values.firstWhere((e) => e.toString() == json['measure'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'price': price,
      'quantity': quantity,
      'measure': measure.toString(),
    };
  }

  label(String symbol) => '$symbol$price / $quantity ${measureAbbr(measure)}';

  double get unitPrice => price / quantity;

}