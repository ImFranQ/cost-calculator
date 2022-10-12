import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/materials/attached_material.dart';
import 'package:cost_calculator/materials/attach_material_form.dart';
import 'package:cost_calculator/utils/buttons.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/input_fields.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductForm extends StatefulWidget {
  final Function(Product) onSaved;
  final Product? product;

  const ProductForm({
    required this.onSaved,
    this.product,
    Key? key
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  List<AttachedMaterial> materials = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init(){
    if(widget.product != null){
      _nameController.text = widget.product!.name;
      materials = widget.product!.materials;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 12),
          InputField.textField('Name', 'Product Name', 
            validator: _validateName, 
            controller: _nameController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: marginSize),
          ..._materials(),
          const SizedBox(height: marginSize),
          Buttons.primary('Save', _submit)
        ],
      ),
    );
  }

  _materials(){
    return [
      headLine('Materials', trailing: _addMaterialButton()),
      ...materials.map((productMaterial) => 
        ListTile(
          title: Text(productMaterial.material.name),
          subtitle: Text('${productMaterial.quantity} ${productMaterial.material.measure.name}'), 
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeMaterial(productMaterial),
          ),
        )
      ),
      if (materials.isEmpty) ...[
        const SizedBox(height: marginSize), 
        Text('Material list is empty', style: TextStyle(
          color: textLightColor
        ))
      ],
    ];
  }

  _addMaterialButton(){
    return InkWell(
      child: const Icon(Icons.add, color: Color(appPrimaryColor)),
      onTap: _showAddMaterialForm,
    );
  }

  _removeMaterial(AttachedMaterial productMaterial) {
    setState(() {
      materials.remove(productMaterial);
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }
    return null;
  }

  _showAddMaterialForm(){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ AttachMaterialForm( onSaved: _saveProduct ) ],
          ),
        );
      },
    );
  }

  _saveProduct(AttachedMaterial data) {
    setState(() { materials.add(data); });
    Navigator.of(context).pop();
  }

  _submit() async {

    if(materials.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one material'))
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Product material = Product(
        uuid: widget.product?.uuid ?? uuid.v1(),
        name: _nameController.text,
        materials: materials
      );

      widget.onSaved(material);
    }
  }

}