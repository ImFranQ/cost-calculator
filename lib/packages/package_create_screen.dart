import 'package:cost_calculator/packages/package.dart';
import 'package:cost_calculator/packages/package_form.dart';
import 'package:cost_calculator/packages/package_service.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';

class PackageCreateScreen extends StatefulWidget {
  const PackageCreateScreen({ Key? key }) : super(key: key);

  @override
  State<PackageCreateScreen> createState() => _PackageCreateScreenState();
}

class _PackageCreateScreenState extends State<PackageCreateScreen> {
  final service = PackageService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Create Package',
        child: Padding(
          padding: paddingAll(),
          child: PackageForm(
            onSaved: _onSaveMaterial,
          ),
        ),
      ),
    );
  }

  _onSaveMaterial(Package data) async {
    await service.saveOne(data);
      
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Package has been created')),
    );

    Navigator.of(context).pop();
  }
}