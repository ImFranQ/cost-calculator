import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/container.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/input_fields.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final percentageController = TextEditingController();
  final symbolController = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    percentageController.text = await setting(Setting.percentage.toString(), defaultValue: '35');
    symbolController.text = await setting(Setting.symbol.toString(), defaultValue: '\$');
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        title: 'Settings',
        loading: _loading,
        actions: [
          IconButton(
            onPressed: () => _save(), 
            icon: const Icon(Icons.check)
          )
        ],
        child: Column(
          children: [
            spacerVertical(),
            Padding(padding: paddingHorizontal(), child: _avanced())
          ],
        ),
      ),
    );
  }

  Widget _avanced(){
    return Column(
      children: [
        headLine('General Settings'),
        Row(
          children: [
            const Expanded(flex: 2, child: ListTile(
              title:  Text('Profit Percentage'),
              subtitle: Text('Define earning margin'),
            )),
            Expanded(child: InputField.textField('Percentage', '35',
              suffix: const Text('%'),
              controller: percentageController,
            )),
          ],
        ),
        Row(
          children: [
            const Expanded(flex: 2, child: ListTile(
              title:  Text('Currency Symbol'),
              subtitle: Text('Set the profit percentage'),
            )),
            Expanded(child: InputField.textField('Symbol', '\$',
              controller: symbolController,
            )),
          ],
        )
      ],
    );
  }

  _save(){
    setting(Setting.percentage.toString(), value: percentageController.text);
    setting(Setting.symbol.toString(), value: symbolController.text);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings has been saved'))
    );
  }
}