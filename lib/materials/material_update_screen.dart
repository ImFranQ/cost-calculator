import 'package:cost_calculator/materials/material_form.dart';
import 'package:cost_calculator/materials/material_service.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:cost_calculator/materials/material.dart' as app_material;

class MaterialUpdateScreen extends StatefulWidget {
  final app_material.Material material;

  const MaterialUpdateScreen({ 
    Key? key,
    required this.material
  }) : super(key: key);

  @override
  State<MaterialUpdateScreen> createState() => _MaterialUpdateScreenState();
}

class _MaterialUpdateScreenState extends State<MaterialUpdateScreen> {
  final materialService = MaterialService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Update Material',
        child: SingleChildScrollView(
          child: Padding(
            padding: paddingAll(),
            child: MaterialForm(
              onSaved: _onSaveMaterial,
              material: widget.material,
            ),
          ),
        ),
      ),
    );
  }

  _onSaveMaterial(app_material.Material material) async {
    await materialService.updateOne(material);
      
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Material updated')),
    );

    Navigator.of(context).pop();
  }
}