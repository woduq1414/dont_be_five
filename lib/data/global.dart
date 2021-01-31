import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
Map<String, dynamic> levelData;
// class Global {
//   static Map<String, dynamic> levelData;
//
//   Global() {
//     print("hello");
//     parseJsonFromAssets('assets/json/levelData.json').then((value) {
//       levelData = value;
//       print(levelData);
//     });
//   }
// }


void init(){
  parseJsonFromAssets('assets/json/levelData.json').then((value) {
    levelData = value;

  });
}
main() {

  init();
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}
