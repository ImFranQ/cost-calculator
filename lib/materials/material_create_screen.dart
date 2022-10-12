import 'package:cost_calculator/materials/material_form.dart';
import 'package:cost_calculator/materials/material_service.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:cost_calculator/materials/material.dart' as app_material;

class MaterialCreateScreen extends StatefulWidget {
  const MaterialCreateScreen({ Key? key }) : super(key: key);

  @override
  State<MaterialCreateScreen> createState() => _MaterialCreateScreenState();
}

class _MaterialCreateScreenState extends State<MaterialCreateScreen> {
  final materialService = MaterialService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Create Material',
        child: Padding(
          padding: paddingAll(),
          child: MaterialForm(
            onSaved: _onSaveMaterial,
          ),
        ),
      ),
    );
  }

  _onSaveMaterial(app_material.Material material) async {
    await materialService.saveOne(material);
      
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Material Saved')),
    );

    Navigator.of(context).pop();
  }
}