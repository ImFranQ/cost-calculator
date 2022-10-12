import 'package:flutter/material.dart';
import 'package:cost_calculator/utils/theme/colors.dart';

var appTheme = ThemeData(
  backgroundColor: const Color(backgroundColor),
  primarySwatch: primaryPalette,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryPalette,
    secondary: secondaryPalette,
  ),
);