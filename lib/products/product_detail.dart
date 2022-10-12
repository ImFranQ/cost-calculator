import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  late String symbol = '';
  late String percent = '1';
  bool _loading = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    symbol = await setting(Setting.symbol.toString(), defaultValue: '\$');
    percent = await setting(Setting.percentage.toString(), defaultValue: '35');
    
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: widget.product.name,
        loading: _loading,
        child: Column(
          children:[
            const SizedBox(height: marginSize),
            Padding(
              padding: paddingHorizontal(),
              child: headLine('Material List'),
            ),
            _materialList(),
            Padding(
              padding: paddingHorizontal(),
              child: headLine('Details'),
            ),
            Container(
              padding: paddingAll(),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Material cost'),
                      Text('$symbol${widget.product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Earnings ($percent%)'),
                      Text('$symbol${widget.product.earning(double.parse(percent)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ],
                  ),
                  Padding(
                    padding: paddingVertical(value: 8),
                    child: Container(height: 1, color: textLightColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Selling price'),
                      Text('$symbol${widget.product.sellingPrice(double.parse(percent)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: paddingVertical(value: 8),
                    child: Container(height: 1, color: textLightColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Production cost'),
                      Text('$symbol${widget.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _materialList(){
    return Column(
      children: widget.product.materials.map((productMaterial) => ListTile(
        title: Text(productMaterial.material.name),
        subtitle: Text(productMaterial.label(symbol)), 
      )).toList(),
    );
  }
}

