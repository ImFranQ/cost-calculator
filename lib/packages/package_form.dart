import 'package:cost_calculator/materials/mearure.dart';
import 'package:cost_calculator/packages/package.dart';
import 'package:cost_calculator/materials/attached_material.dart';
import 'package:cost_calculator/products/attach_product_form.dart';
import 'package:cost_calculator/products/attached_product.dart';
import 'package:cost_calculator/materials/attach_material_form.dart';
import 'package:cost_calculator/utils/buttons.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/input_fields.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PackageForm extends StatefulWidget {
  final Function(Package) onSaved;
  final Package? package;

  const PackageForm({
    required this.onSaved,
    this.package,
    Key? key
  }) : super(key: key);

  @override
  _PackageFormState createState() => _PackageFormState();
}

class _PackageFormState extends State<PackageForm> {
  final uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  List<AttachedMaterial> materials = [];
  List<AttachedProduct> products = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init(){
    if(widget.package != null){
      _nameController.text = widget.package!.name;
      materials = widget.package!.materials;
      products = widget.package!.products;
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(padding: paddingTop()),
          InputField.textField('Name', 'Material Name', 
            validator: _validateName, 
            controller: _nameController,
            keyboardType: TextInputType.text,
          ),
          Padding(padding: paddingTop()),
          ..._products(),
          Padding(padding: paddingTop()),
          ..._materials(),
          Padding(padding: paddingTop()),
          Buttons.primary('Save', _submit)
        ],
      ),
    );
  }

  List<Widget> _materials() {
    return [
      headLine('Materials', trailing: _addMaterialButton()),
      ...materials.map((productMaterial) => 
        ListTile(
          title: Text(productMaterial.material.name),
          subtitle: Text('${productMaterial.quantity} ${measureAbbr(productMaterial.material.measure)}'), 
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeMaterial(productMaterial),
          ),
        )
      ),
      if (materials.isEmpty) ...[
        Padding(padding: paddingTop()),
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

  List<Widget> _products() {
    return [
      headLine('Products', trailing: _addProductButton()),
      ...products.map((attachedProduct) => 
        ListTile(
          title: Text(attachedProduct.product.name),
          subtitle: Text('${attachedProduct.quantity} u.'), 
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeProduct(attachedProduct),
          ),
        )
      ),
      if (products.isEmpty) ...[
        Padding(padding: paddingTop()),
        Text('Product list is empty', style: TextStyle(
          color: textLightColor
        ))
      ],
    ];
  }

  _addProductButton(){
    return InkWell(
      child: const Icon(Icons.add, color: Color(appPrimaryColor)),
      onTap: _showAddProductForm,
    );
  }

  _removeProduct(AttachedProduct attachedProduct) {
    setState(() => products.remove(attachedProduct));
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

  _showAddProductForm() {
    _showAlert('Add Product', AttachProductForm( onSaved: _saveProduct ));
  }

  _showAddMaterialForm(){
    _showAlert('Add Material', AttachMaterialForm( onSaved: _saveMaterial ));
  }

  _showAlert(String title, Widget content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ content ],
        ),
      ),
    );
  }

  _saveMaterial(AttachedMaterial data) {
    setState(() { materials.add(data); });
    Navigator.of(context).pop();
  }

  _saveProduct(AttachedProduct data) {
    setState(() { products.add(data); });
    Navigator.of(context).pop();
  }

  _submit() async {

    // if(materials.isEmpty){
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please add at least one material'))
    //   );
    //   return;
    // }

    if(products.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one product'))
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Package material = Package(
        uuid: widget.package?.uuid ?? uuid.v1(),
        name: _nameController.text,
        materials: materials,
        products: products
      );

      widget.onSaved(material);
    }
  }

}