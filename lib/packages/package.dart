import 'package:cost_calculator/materials/attached_material.dart';
import 'package:cost_calculator/products/attached_product.dart';

class Package {
  String uuid;
  String name;
  List<AttachedMaterial> materials;
  List<AttachedProduct> products;

  Package({
    required this.uuid,
    required this.name,
    required this.materials,
    required this.products,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      uuid: json['uuid'],
      name: json['name'],
      materials: (json['materials'] as List)
          .map((material) => AttachedMaterial.fromJson(material))
          .toList(),
      products: (json['products'] as List)
          .map((product) => AttachedProduct.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'materials': materials.map((material) => material.toJson()).toList(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  } 

  copyWith({
    String? uuid,
    String? name,
    List<AttachedMaterial>? materials,
    List<AttachedProduct>? products,
  }) =>
      Package(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        materials: materials ?? this.materials,
        products: products ?? this.products,
      );

  double get totalProductPrice => products.fold(0, (sum, product) => sum + product.price);

  double get totalMaterialPrice => materials.fold(0, (sum, material) => sum + material.price);

  double get totalPrice => totalProductPrice + totalMaterialPrice;

  double earning( double percentage) {
    return totalPrice * percentage / 100;
  }

  double sellingPrice( double percentage ) {
    return totalPrice + earning(percentage);
  }

  String label(String symbol) {
    return 'Cost: $symbol${totalPrice.toStringAsFixed(2)}';
  }
}