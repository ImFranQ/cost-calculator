import 'package:cost_calculator/packages/package.dart';
import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class PackageDetail extends StatefulWidget {
  final Package package;

  const PackageDetail({
    required this.package,
    Key? key 
  }) : super(key: key);

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {

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
        loading: _loading,
        title: widget.package.name,
        child: Column(
          children: [
            spacerHorizontal(),
            _productList(),
            _materialList(),
            _details(),
            spacerHorizontal(),
          ],
        ),
      ),
    );
  }

  _materialList(){
    return Column(
      children: [
         Padding(
          padding: paddingHorizontal(),
          child: headLine('Material List'),
        ),
        ...widget.package.materials.map((packageMaterial) => ListTile(
          title: Text(packageMaterial.material.name),
          subtitle: Text(packageMaterial.label(symbol)),
        )).toList(),
        if(widget.package.materials.isEmpty) const Center(
          child: Text('No materials added yet')
        ),
      ],
    );
  }

  _productList(){
    return Column(
      children: [
        Padding(
          padding: paddingHorizontal(),
          child: headLine('Product List'),
        ),
        ...widget.package.products.map((packageProduct) => ListTile(
          title: Text(packageProduct.product.name),
          subtitle: Text(packageProduct.label(symbol)),
        )).toList()
      ],
    );  
  }

  _details(){
    return Column(
      children: [
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
                  const Text('Products cost'),
                  Text('$symbol${widget.package.totalProductPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Materials cost'),
                  Text('$symbol${widget.package.totalMaterialPrice.toStringAsFixed(2)}',
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
                  Text('$symbol${widget.package.earning(double.parse(percent)).toStringAsFixed(2)}',
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
                  Text('$symbol${widget.package.sellingPrice(double.parse(percent)).toStringAsFixed(2)}',
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
                  Text('$symbol${widget.package.totalPrice.toStringAsFixed(2)}',
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
    );
  }

}