// import 'dart:convert';
import 'dart:convert';

import 'package:cost_calculator/materials/material.dart';
import 'package:cost_calculator/storage/storage_service.dart';

class MaterialService {

  // Fomater from string to Material
  Material _formatterToMaterial(String e) => Material.fromJson(json.decode(e));

  // Get all materials
  Future<List<Material>> getList() async {
    List<String> items = await StorageService.getStringList('materials');
    return items.map(_formatterToMaterial).toList();
  }

  // Save one material
  Future<bool> saveOne(Material data) async {
    List<String> items = await StorageService.getStringList('materials');
    items.add(json.encode(data.toJson()));
    await StorageService.setStringList('materials', items);
    return true;
  }

  // Get one material
  Future<Material> getOne(String uuid) async {
    List<String> items = await StorageService.getStringList('materials');
    return items.map(_formatterToMaterial).firstWhere((element) => element.uuid == uuid);
  }

  // Update one material
  Future<bool> updateOne(Material data) async {
    List<String> items = await StorageService.getStringList('materials');
    items = items.map((e) => _formatterToMaterial(e).uuid == data.uuid ? json.encode(data.toJson()) : e).toList();
    await StorageService.setStringList('materials', items);
    return true;
  }

  // Delete one material  
  Future<bool> deleteOne(String uuid) async {
    List<String> items = await StorageService.getStringList('materials');
    items = items.where((e) => _formatterToMaterial(e).uuid != uuid).toList();
    await StorageService.setStringList('materials', items);
    return true;
  }

}