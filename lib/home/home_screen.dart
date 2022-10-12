// home scrren
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/images.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Home',
        actions: _actions(context),
        child: Padding(
          padding: paddingAll(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: marginSizeSm),
              _listItem(context, 'Materials', 'materials', imagePath: utilsPath),
              const SizedBox(height: marginSizeSm),
              _listItem(context, 'Products', 'products', imagePath: blocknotePath),
              const SizedBox(height: marginSizeSm),
              _listItem(context, 'Packages', 'packages', imagePath: boardPath),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(
    BuildContext context, 
    String title, 
    String route, 
    {String? imagePath}
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/$route'),
      child: Container(
        padding: paddingAll(),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            imagePath != null 
              ? SvgPicture.asset(imagePath, height: 24,) 
              : const SizedBox(width: 24, height: 24),
            const SizedBox(width: marginSize),
            Expanded(child: Text(
              title, 
              style: const TextStyle(
                fontSize: 16.0
              )
            )),
            Icon(Icons.arrow_forward_ios, color: textLightColor),
          ],
        ),
      ),
    );
  }

  List<Widget> _actions(BuildContext context){
    return [
      IconButton(
        onPressed: ()=> _showItemBottomSheet(context),
        icon: const Icon(Icons.more_vert)
      )
    ];
  }

  void _showItemBottomSheet(BuildContext context) {   
    showModalBottomSheet(context: context, builder: (builder){
      return Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      );
    });
  }
}