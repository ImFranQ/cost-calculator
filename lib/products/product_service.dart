// import 'dart:convert';
import 'dart:convert';

import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/storage/storage_service.dart';

class ProductService {

  // Fomater from string to Product
  Product _formatterToProduct(String e) => Product.fromJson(json.decode(e));

  // Get all products
  Future<List<Product>> getList() async {
    List<String> stringList = await StorageService.getStringList('products');
    return stringList.map<Product>(_formatterToProduct).toList();
  }

  // Save one product
  Future<bool> saveOne(Product data) async {
    List<String> items = await StorageService.getStringList('products');
    items.add(json.encode(data.toJson()));
    await StorageService.setStringList('products', items);
    return true;
  }

  // Get one product
  Future<Product> getOne(String uuid) async {
    List<String> stringList = await StorageService.getStringList('products');
    return stringList.map(_formatterToProduct).firstWhere((element) => element.uuid == uuid);
  }

  // Update one product
  Future<bool> updateOne(Product data) async {
    List<String> items = await StorageService.getStringList('products');
    items = items.map((e) => _formatterToProduct(e).uuid == data.uuid ? json.encode(data.toJson()) : e).toList();
    await StorageService.setStringList('products', items);
    return true;
  }

  // delete one product
  Future<bool> deleteOne(String uuid) async {
    List<String> items = await StorageService.getStringList('products');
    items = items.where((e) => _formatterToProduct(e).uuid != uuid).toList();
    await StorageService.setStringList('products', items);
    return true;
  }

}