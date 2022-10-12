import 'package:cost_calculator/products/product.dart';
import 'package:cost_calculator/products/product_create_screen.dart';
import 'package:cost_calculator/products/product_detail.dart';
import 'package:cost_calculator/products/product_service.dart';
import 'package:cost_calculator/products/product_update_screen.dart';
import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/dialogs.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({ Key? key }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final service = ProductService();
  final uuid = const Uuid();
  late String symbol;
  bool _loading = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    String symbol = await setting(Setting.symbol.toString(), defaultValue: '\$');
    setState(() {
      this.symbol = symbol;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Product List',
        loading: _loading,
        child: Column(
          children: [
            const SizedBox(height: marginSize),
            _materialList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ProductCreateScreen() 
          ));

          setState(() { });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _materialList(){
    return FutureBuilder(
      future: service.getList(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return const Text('No products');
          }

          return Column(
            children: snapshot.data!.map((product) => _productItem(product)).toList(),
          );

        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _productItem (Product product) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text("Cost: $symbol${product.price}"),
      onTap: () => _showProduct(product),
      trailing: IconButton(
        onPressed: () =>  _showItemBottomSheet(product),
        icon: const Icon(Icons.more_vert),
      ),
    );
  }

  void _showItemBottomSheet(Product product) {   
    showModalBottomSheet(context: context, builder: (builder){
      return Wrap(
        children: [

          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Update'),
            onTap: () => _updateMaterial(product),
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Create copy'),
            onTap: () => _copyMaterial(product),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () => _deleteMaterial(product),
          ),
        ],
      );
    });
  }

  void _updateMaterial(Product product) async {
    Navigator.pop(context);
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => ProductUpdateScreen(product: product) 
    ));
    setState(() { });
  }

  void _showProduct(Product product){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ProductDetail(product:product) 
    ));
  }

  void _deleteMaterial(Product product) {
    Navigator.pop(context);
    AppDialog.confirm(
      context, 
      'Confirmation', 
      'Sure you want delete this product?', 
      () async {
        await service.deleteOne(product.uuid);
        setState(() { });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product has been deleted')),
        );
      }
    );
  }

  void _copyMaterial(Product product) {
    Navigator.pop(context);
    Product newProduct = product.copyWith(
      uuid: uuid.v1(),
      name: 'Copy of ${product.name}'
    );

    AppDialog.confirm(
      context, 
      'Confirmation', 
      'Sure you want copy this product?', 
      () async {
        await service.saveOne(newProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product has been copied')),
        );
        setState(() { });
      }
    );
  }
}