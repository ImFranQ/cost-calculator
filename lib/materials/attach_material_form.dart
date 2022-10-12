import 'package:cost_calculator/materials/material.dart' as app_material;
import 'package:cost_calculator/materials/material_service.dart';
import 'package:cost_calculator/materials/attached_material.dart';
import 'package:cost_calculator/materials/mearure.dart';
import 'package:cost_calculator/utils/buttons.dart';
import 'package:cost_calculator/utils/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttachMaterialForm extends StatefulWidget {
  final Function(AttachedMaterial) onSaved;

  const AttachMaterialForm({
    required this.onSaved,  
    Key? key
  }) : super(key: key);

  @override
  State<AttachMaterialForm> createState() => _AttachMaterialFormState();
}

class _AttachMaterialFormState extends State<AttachMaterialForm> {

  final materialService = MaterialService();
  final _cuantityContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  app_material.Material? _selectedMaterial;
  String? _materialUuid;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: materialService.getList(),
        builder: (BuildContext context, AsyncSnapshot<List<app_material.Material>> snapshot) {
          if (snapshot.hasData) {

            if(snapshot.data!.isEmpty) return const Text('Do you need to add materials first');
            
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField.select(
                    'Material',
                    value: _materialUuid,
                    options: snapshot.data!.map<Map<String, dynamic>>((material) => {
                      'value': material.uuid,
                      'label': material.name
                    }).toList(),
                    onChange: _materialSelected
                  ),
                  const SizedBox(height: 12),
                  InputField.textField('Cuantity', 'Cuantity to use', 
                    validator: (value) => value!.isEmpty ? 'Cuantity is required' : null, 
                    controller: _cuantityContoller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
                    ],
                    suffix: _selectedMaterial != null ? Text(measureAbbr(_selectedMaterial!.measure)) : null
                  ),
                  const SizedBox(height: 12),
                  Buttons.primary('Add', _submitMaterial),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _materialSelected(value) async {
    _materialUuid = value;
    _selectedMaterial = await materialService.getOne(_materialUuid!);
    setState(() { });
  }

  _submitMaterial() async {
    if(_selectedMaterial == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a material first'))
      );
      return;
    }

    if (_formKey.currentState!.validate() && _materialUuid!.isNotEmpty) {
      var product = AttachedMaterial(
        quantity: double.parse(_cuantityContoller.text),
        material: _selectedMaterial!
      );

      widget.onSaved(product);
    }

  }
}