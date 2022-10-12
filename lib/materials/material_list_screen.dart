import 'package:cost_calculator/materials/material.dart' as app_material;
import 'package:cost_calculator/materials/material_create_screen.dart';
import 'package:cost_calculator/materials/material_service.dart';
import 'package:cost_calculator/materials/material_update_screen.dart';
import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/dialogs.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:flutter/material.dart';

class MaterialListScreen extends StatefulWidget {
  const MaterialListScreen({ Key? key }) : super(key: key);

  @override
  State<MaterialListScreen> createState() => _MaterialListScreenState();
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  final materialService = MaterialService();
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
        title: 'Your materials',
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
            builder: (context) => const MaterialCreateScreen() 
          ));

          setState(() { });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _materialList(){
    return FutureBuilder(
      future: materialService.getList(),
      builder: (BuildContext context, AsyncSnapshot<List<app_material.Material>> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return const Text('No materials');
          }

          return Column(
            children: snapshot.data!.map((material) => _materialItem(material)).toList(),
          );

        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _materialItem (app_material.Material material) {
    return ListTile(
      trailing: IconButton(
        onPressed: () =>  _showItemBottomSheet(material),
        icon: const Icon(Icons.more_vert),
      ),
      title: Text(material.name),
      subtitle: Text('${material.label(symbol)}'),
    );
  }


  void _showItemBottomSheet(app_material.Material material) {   
    showModalBottomSheet(context: context, builder: (builder){
      return Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Update'),
            onTap: () => _updateMaterial(material),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () => _deleteMaterial(material),
          ),
        ],
      );
    });
  }

  void _updateMaterial(app_material.Material material) async {
    Navigator.pop(context);
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => MaterialUpdateScreen(material: material) 
    ));
    setState(() { });
  }

  void _deleteMaterial(app_material.Material material) {
    Navigator.pop(context);
    AppDialog.confirm(
      context, 
      'Confirmation', 
      'Sure you want delete this material?', 
      () async {
        await materialService.deleteOne(material.uuid);
        setState(() { });
      }
    );
  }

}