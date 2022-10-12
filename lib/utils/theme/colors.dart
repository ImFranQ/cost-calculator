import 'package:flutter/material.dart';

const int appPrimaryColor = 0xFF45596B;
const int appSecondaryColor = 0xFF6EC4A7;
const int appAccentColor = 0xFFC1FFE6;

const int backgroundColor = 0xFFE9EBED;
Color borderColor = Colors.grey[300]!;
Color textLightColor = Colors.grey[500]!;

const MaterialColor primaryPalette = MaterialColor(appPrimaryColor, <int, Color>{
  50: Color(backgroundColor),
  100: Color(0xFFC7CDD3),
  200: Color(0xFFA2ACB5),
  300: Color(0xFF7D8B97),
  400: Color(0xFF617281),
  500: Color(appPrimaryColor),
  600: Color(0xFF3E5163),
  700: Color(0xFF364858),
  800: Color(0xFF2E3E4E),
  900: Color(0xFF1F2E3C),
});

const MaterialColor secondaryPalette = MaterialColor(appSecondaryColor, <int, Color>{
  50: Color(0xFFEEF8F4),
  100: Color(0xFFD4EDE5),
  200: Color(0xFFB7E2D3),
  300: Color(0xFF9AD6C1),
  400: Color(0xFF84CDB4),
  500: Color(appSecondaryColor),
  600: Color(0xFF66BE9F),
  700: Color(0xFF5BB696),
  800: Color(0xFF51AF8C),
  900: Color(0xFF3FA27C),
});

const MaterialColor appAccent = MaterialColor(appAccentColor, <int, Color>{
  100: Color(0xFFF4FFFB),
  200: Color(appAccentColor),
  400: Color(0xFF8EFFD2),
  700: Color(0xFF74FFC8),
});