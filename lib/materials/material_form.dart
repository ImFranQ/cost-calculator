// state full
import 'package:cost_calculator/materials/material.dart' as app_material;
import 'package:cost_calculator/materials/mearure.dart';
import 'package:cost_calculator/utils/buttons.dart';
import 'package:cost_calculator/utils/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class MaterialForm extends StatefulWidget {
  final Function(app_material.Material) onSaved;
  final app_material.Material? material;

  const MaterialForm({
    required this.onSaved,
    this.material,
    Key? key
  }) : super(key: key);

  @override
  _MaterialFormState createState() => _MaterialFormState();
}

class _MaterialFormState extends State<MaterialForm> {

  final uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  Measure? measureValue;
  
  @override
  initState() {
    super.initState();
    if (widget.material != null) {
      _nameController.text = widget.material!.name;
      _priceController.text = widget.material!.price.toString();
      _quantityController.text = widget.material!.quantity.toString();
      measureValue = widget.material!.measure;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 12),
          InputField.textField('Name', 'Material Name', 
            validator: _validateName, 
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 12),
          InputField.textField('Price', 'Price', 
            validator: _validatePrice, 
            controller: _priceController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: InputField.textField('Count', 'Total count', 
                validator: _validateUnits, 
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ]
              )),
              const SizedBox(width: 12),
              Expanded(child: InputField.select(
                'Measure', 
                onChange: (value) => setState((){
                  measureValue = value as Measure;
                }), 
                options: measureListOptions(),
                value: measureValue,
              )),
            ],
          ),

          const SizedBox(height: 12),
          Buttons.primary('Save', _submit),
        ],
      ),
    );
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter price';
    }
    return null;
  }

  String? _validateUnits(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter units';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }
    return null;
  }

  _submit() async {
    if (_formKey.currentState!.validate() && measureValue != null) {
      app_material.Material material = app_material.Material(
        uuid: widget.material?.uuid ?? uuid.v1(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: double.parse(_quantityController.text),
        measure: measureValue!
      );

      widget.onSaved(material);
    }
  }

}