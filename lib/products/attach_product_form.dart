import 'package:cost_calculator/products/attached_product.dart';
import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/products/product_service.dart';
import 'package:cost_calculator/utils/buttons.dart';
import 'package:cost_calculator/utils/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttachProductForm extends StatefulWidget {
  final Function(AttachedProduct) onSaved;

  const AttachProductForm({
    required this.onSaved,  
    Key? key
  }) : super(key: key);

  @override
  State<AttachProductForm> createState() => _AttachProductFormState();
}

class _AttachProductFormState extends State<AttachProductForm> {

  final service = ProductService();
  final _cuantityContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _materialUuid;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: service.getList(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {

            if(snapshot.data!.isEmpty) return const Text('Do you need to add product first');
            
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField.select(
                    'Product',
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
                    suffix: const Text('u.')
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
    setState(() {
      _materialUuid = value;
    });
  }

  _submitMaterial() async {
    if (_formKey.currentState!.validate() && _materialUuid!.isNotEmpty) {
      var attached = AttachedProduct(
        quantity: double.parse(_cuantityContoller.text),
        product: await service.getOne(_materialUuid!)
      );

      widget.onSaved(attached);
    }

  }
}