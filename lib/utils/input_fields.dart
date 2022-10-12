
import 'package:cost_calculator/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField {

  static Widget _textField(String label, String hint, bool obscureText, {
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffix,
    Widget? prefix,
  }) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: paddingSymmetric(vertical: 15, horizontal: 12),
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        suffix: suffix,
        prefix: prefix
      ),
    );
  }

  // password field
  static Widget passwordField(String label, String hint,{
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffix,
    Widget? prefix,
  }) {
    return _textField(label, hint, true, 
      validator: validator, 
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      suffix: suffix,
      prefix: prefix
    );
  }

  // text field
  static Widget textField(String label, String hint, {
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffix,
    Widget? prefix,
  }) {
    return _textField(label, hint, false, 
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      suffix: suffix,
      prefix: prefix
    );
  }

  static Widget select(String hint, {
    List<Map<String, dynamic>> options = const [],
    void Function(Object?)? onChange,
    dynamic value
  }){
    return Container(
      padding: paddingHorizontal(value: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: const Color(0xFF9B9B9B), 
          style: BorderStyle.solid, 
        ),
      ),
      child: DropdownButton(
        value: value,
        hint: Text(hint),
        underline: Container( height: 0, ),
        isExpanded: true,
        items: options.map((option) => DropdownMenuItem(
          child: Text(option['label']),
          value: option['value'],
        )).toList(),
        onChanged: onChange,
      ),
    );
  }

}