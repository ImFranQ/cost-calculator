import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';

class Buttons {
  // button

  static Widget _button(String text, VoidCallback? onPressed){
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton (
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          padding: paddingVertical(value: 12),
          // primary: Colors.blue,
          // onPrimary: Colors.white,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          // ),
        ),
      ),
    );
  }

  static Widget primary(String text, VoidCallback? onPressed) {
    return _button(text, onPressed);
  }
}