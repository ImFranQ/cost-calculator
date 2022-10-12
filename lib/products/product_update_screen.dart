import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/products/product_form.dart';
import 'package:cost_calculator/products/product_service.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';

class ProductUpdateScreen extends StatefulWidget {

  final Product product;
  
  const ProductUpdateScreen({ 
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final service = ProductService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Update Product',
        child: Padding(
          padding: paddingAll(),
          child: ProductForm(
            onSaved: _onSaveMaterial,
            product: widget.product,
          ),
        ),
      ),
    );
  }

  _onSaveMaterial(Product product) async {
    await service.updateOne(product);
      
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Material Saved')),
    );

    Navigator.of(context).pop();
  }
}