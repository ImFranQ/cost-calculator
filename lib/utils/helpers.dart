import 'package:cost_calculator/storage/storage_service.dart';
import 'package:cost_calculator/utils/sizes.dart';
import 'package:cost_calculator/utils/theme/colors.dart';
import 'package:flutter/material.dart';

Widget headLine(String title, {
  Widget? trailing,
}) {
  return Column(
    children: [
      const SizedBox(height: marginSizeSm),
      Row(
        children: [
          const SizedBox(width: marginSizeSm),
          Expanded(child: Text(title.toUpperCase(), 
            style: const TextStyle(
              color: Color(appPrimaryColor),
              fontWeight: FontWeight.bold
            )
          )),
          if(trailing != null) ...[trailing, const SizedBox(width: marginSizeSm)]
        ],
      ),
      const SizedBox(height: marginSizeSm),
      Container(color: const Color(appPrimaryColor), height: 1,)
    ],
  );
}

EdgeInsets paddingAll({double value = marginSize}) => EdgeInsets.all(value);
EdgeInsets paddingTop({double value = marginSize}) => EdgeInsets.only(top: value);
EdgeInsets paddingBottom({double value = marginSize}) => EdgeInsets.only(bottom: value);
EdgeInsets paddingLeft({double value = marginSize}) => EdgeInsets.only(left: value);
EdgeInsets paddingRight({double value = marginSize}) => EdgeInsets.only(right: value);
EdgeInsets paddingVertical({double value = marginSize}) => EdgeInsets.symmetric(vertical: value);
EdgeInsets paddingHorizontal({double value = marginSize}) => EdgeInsets.symmetric(horizontal: value);
EdgeInsets paddingSymmetric({double vertical = marginSize, double horizontal = marginSize}) => EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);

Widget spacer({double height = marginSize, double width = marginSize}) => SizedBox(height: height, width: width);
Widget spacerHorizontal({double width = marginSize}) => spacer(width: width);
Widget spacerVertical({double height = marginSize}) => spacer(height: height);  

Future<String> setting(String key, {String defaultValue = '', String? value, bool setIfNotExists = false}) async {
  if(value != null && !setIfNotExists) {
    await StorageService.setString(key, value);
    return value;
  }
  
  var val = await StorageService.getString(key);

  if(val == null && setIfNotExists && defaultValue.isNotEmpty) {
    await StorageService.setString(key, defaultValue);
    return defaultValue;
  }

  return val ?? defaultValue;
}