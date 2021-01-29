


import 'package:dont_be_five/data/LevelData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';





class GlobalStatus with ChangeNotifier {
//  KakaoContext.clientId = '39d6c43a0a346cca6ebc7b2dbb8e4353';


  List<LevelData> levelDataList;
  int currentLevel = 0;

  GlobalStatus() {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    init();
  }




  init() async {
    print("init!!");

    Map<String, dynamic> data = await parseJsonFromAssets('assets/json/levelData.json');
    levelDataList = data["levels"].map<LevelData>((x) => LevelData.fromJson(x)).toList();
    print(levelDataList);
    notifyListeners();
  }
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}