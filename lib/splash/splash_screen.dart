import 'package:cost_calculator/settings/settings.dart';
import 'package:cost_calculator/utils/helpers.dart';
import 'package:cost_calculator/utils/images.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    // timer to navigate to home screen
    await setting(Setting.percentage.toString(), defaultValue: '35', setIfNotExists: true);
    await setting(Setting.symbol.toString(), defaultValue: '\$', setIfNotExists: true);
    
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(backgroundColor),
        child: SafeArea(
          child: Center(
            child: Image.asset(appLogoPath),
          ),
        ),
      )
    );
  }
}