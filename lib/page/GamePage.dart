import 'dart:convert';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  int level;

  GamePage({this.level});

  @override
  _GamePageState createState() => _GamePageState(level);
}

class _GamePageState extends State<GamePage> {
  int level;
  LevelData _currentLevelData;

  _GamePageState(this.level);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (levelData == null) {
        // List<LevelData> levelDataList =context.select((GlobalStatus gs) => gs.levelDataList);
        GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
        List<LevelData> levelDataList = gs.levelDataList;

        if (levelDataList != null) {
          print("nonu");
          _currentLevelData = levelDataList.firstWhere((el) => el.seq == level);
          print(_currentLevelData.map);
        } else {}
      }
    });
    print(_currentLevelData);

    return Container(
      child: GameMap(levelData: _currentLevelData,),
    );
  }
}
