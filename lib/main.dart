import 'package:cost_calculator/home/home_screen.dart';
import 'package:cost_calculator/materials/material_list_screen.dart';
import 'package:cost_calculator/packages/package_list_screen.dart';
import 'package:cost_calculator/products/product_list_screen.dart';
import 'package:cost_calculator/settings/settings_screen.dart';
import 'package:cost_calculator/splash/splash_screen.dart';
import 'package:cost_calculator/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const SplashScreen(),
      routes: {
      '/home': (context) => const HomeScreen(),
      '/materials': (context) => const MaterialListScreen(),
      '/products': (context) => const ProductListScreen(),
      '/packages': (context) => const PackageListScreen(),
      '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}