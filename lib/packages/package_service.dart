// import 'dart:convert';
import 'dart:convert';

import 'package:cost_calculator/packages/package.dart';
import 'package:cost_calculator/storage/storage_service.dart';

class PackageService {

  // Fomater from string to Package
  Package _formatterToPackage(String e) => Package.fromJson(json.decode(e));

  // Get all packages
  Future<List<Package>> getList() async {
    List<String> stringList = await StorageService.getStringList('packages');
    return stringList.map<Package>(_formatterToPackage).toList();
  }

  // Save one package
  Future<bool> saveOne(Package data) async {
    List<String> items = await StorageService.getStringList('packages');
    items.add(json.encode(data.toJson()));
    await StorageService.setStringList('packages', items);
    return true;
  }

  // Get one package
  Future<Package> getOne(String uuid) async {
    List<String> stringList = await StorageService.getStringList('packages');
    return stringList.map(_formatterToPackage).firstWhere((element) => element.uuid == uuid);
  }

  // Update one package
  Future<bool> updateOne(Package data) async {
    List<String> stringList = await StorageService.getStringList('packages');
    stringList = stringList.map((e) => _formatterToPackage(e).uuid == data.uuid ? json.encode(data.toJson()) : e).toList();
    await StorageService.setStringList('packages', stringList);
    return true;
  }

  // Delete one package
  Future<bool> deleteOne(String uuid) async {
    List<String> stringList = await StorageService.getStringList('packages');
    stringList = stringList.map((e) => _formatterToPackage(e).uuid == uuid ? '' : e).toList();
    await StorageService.setStringList('packages', stringList);
    return true;
  }

}