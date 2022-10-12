import 'package:cost_calculator/materials/attached_material.dart';

class Product{
  String uuid;
  String name;
  List<AttachedMaterial> materials;

  Product({
    required this.uuid,
    required this.name,
    required this.materials,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    uuid: json["uuid"],
    name: json['name'],
    materials: json['materials'].map<AttachedMaterial>((e) => AttachedMaterial.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'name': name,
    'materials': materials.map((e) => e.toJson()).toList(),
  };

  double get price {
    return materials.map((e) => e.price).reduce((value, element) => value + element);
  }

  double earning( double percentage) {
    return price * percentage / 100;
  }

  double sellingPrice( double percentage ) {
    return price + earning(percentage);
  }

  copyWith({
    String? uuid,
    String? name,
    List<AttachedMaterial>? materials,
  }) => Product(
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    materials: materials ?? this.materials,
  );

}