import 'package:cost_calculator/packages/package.dart';
import 'package:cost_calculator/packages/package_form.dart';
import 'package:cost_calculator/packages/package_service.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';

class PackageUpdateScreen extends StatefulWidget {

  final Package package;
  
  const PackageUpdateScreen({ 
    Key? key,
    required this.package,
  }) : super(key: key);

  @override
  State<PackageUpdateScreen> createState() => _PackageUpdateScreenState();
}

class _PackageUpdateScreenState extends State<PackageUpdateScreen> {
  final service = PackageService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Update Package',
        child: Padding(
          padding: paddingAll(),
          child: PackageForm(
            onSaved: _onSaveMaterial,
            package: widget.package,
          ),
        ),
      ),
    );
  }

  _onSaveMaterial(Package data) async {
    await service.updateOne(data);
      
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Package has been updated')),
    );

    Navigator.of(context).pop();
  }
}