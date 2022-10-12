import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/products/product_form.dart';
import 'package:cost_calculator/products/product_service.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({ Key? key }) : super(key: key);

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final service = ProductService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Create Product',
        child: Padding(
          padding: paddingAll(),
          child: ProductForm(
            onSaved: _onSaveMaterial,
          ),
        ),
      ),
    );
  }

  _onSaveMaterial(Product product) async {
    await service.saveOne(product);
      
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Material Saved')),
    );

    Navigator.of(context).pop();
  }
  
}