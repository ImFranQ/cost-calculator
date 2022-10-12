import 'package:cost_calculator/packages/package.dart';
import 'package:cost_calculator/packages/package_create_screen.dart';
import 'package:cost_calculator/packages/package_detail.dart';
import 'package:cost_calculator/packages/package_service.dart';
import 'package:cost_calculator/packages/package_update_screen.dart';
import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/dialogs.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({ Key? key }) : super(key: key);

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  final uuid = const Uuid();
  final service = PackageService();
  late String symbol = '';
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
        title: 'Package List',
        loading: _loading,
        child: Column(
          children: [
            const SizedBox(height: marginSize),
            _packageList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) => const PackageCreateScreen() 
          ));

          setState(() { });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _packageList(){
    return FutureBuilder(
      future: service.getList(),
      builder: (BuildContext context, AsyncSnapshot<List<Package>> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return const Text('No packages');
          }

          return Column(
            children: snapshot.data!.map((package) => _productItem(package)).toList(),
          );

        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _productItem (Package package) {
    return ListTile(
      title: Text(package.name),
      subtitle: Text(package.label(symbol)),
      onTap: () => _showPackage(package),
      trailing: IconButton(
        onPressed: () =>  _showItemBottomSheet(package),
        icon: const Icon(Icons.more_vert),
      ),
    );
  }

  void _showItemBottomSheet(Package package) {   
    showModalBottomSheet(context: context, builder: (builder){
      return Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Update'),
            onTap: () => _updatePackage(package),
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Create copy'),
            onTap: () => _copyPackage(package),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () => _deletePackage(package),
          ),
        ],
      );
    });
  }

  void _updatePackage(Package package) async {
    Navigator.pop(context);
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => PackageUpdateScreen(package: package) 
    ));
    setState(() { });
  }

  void _showPackage(Package package){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PackageDetail(package:package) 
    ));
  }

  void _deletePackage(Package package) {
    Navigator.pop(context);
    AppDialog.confirm(
      context, 
      'Confirmation', 
      'Sure you want delete this package?', 
      () async {
        await service.deleteOne(package.uuid);
        setState(() { });
      }
    );
  }

  void _copyPackage(Package product) {
    Navigator.pop(context);
    Package newPackage = product.copyWith(
      uuid: uuid.v1(),
      name: 'Copy of ${product.name}'
    );

    AppDialog.confirm(
      context, 
      'Confirmation', 
      'Sure you want copy this package?', 
      () async {
        await service.saveOne(newPackage);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Package has been copied')),
        );
        setState(() { });
      }
    );
  }
}