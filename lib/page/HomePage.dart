import 'dart:convert';
import 'dart:math';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import 'GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    return Scaffold(
        body: Center(
            child: RaisedButton(
              child: Text("gg"),
              onPressed: () async {
                moveToLevel(level: 1, context: context);
              },
            )));
  }



}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) =>  random.nextInt(255));
  return base64UrlEncode(values);
}

void moveToLevel({int level, BuildContext context}) async {
  GlobalStatus gs = context.read<GlobalStatus>();
  // GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  List<LevelData> levelDataList = gs.levelDataList;
  LevelData _currentLevelData;
  gs.initLevel();


  _currentLevelData = levelDataList.firstWhere((el) => el.seq == level);


  gs.levelData = _currentLevelData.clone();
  gs.tileCornerOffsetList = calcTileCornerOffsetList(levelData: _currentLevelData, context: context);
  gs.personDataList = makePersonDataList(levelData: _currentLevelData, context: context);


  for(int i = 0 ; i < _currentLevelData.mapHeight; i ++){
    for(int j = 0; j < _currentLevelData.mapWidth ; j++){
      if(Tiles.getTileType(tile: TileData(x:j, y:i), levelData: _currentLevelData) == Tiles.goal){
        gs.goalTile = TileData(x:j, y:i);
        break;
      }
    }
  }


  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              GamePage(
                level: 1,
              )));
}



List<dynamic> calcTileCornerOffsetList({LevelData levelData, BuildContext context}) {



  double deviceWidth;
  double deviceHeight;

  Offset leftTopCorner;
  Offset rightTopCorner;
  Offset leftBottomCorner;
  Offset rightBottomCorner;

  List<dynamic> _tileCornerOffsetList = [];

  deviceWidth = MediaQuery
      .of(context)
      .size
      .width;
  deviceHeight = MediaQuery
      .of(context)
      .size
      .height;


  // setState(() {
  //   _tileCornerOffsetList[0] = deviceWidth;
  // });
  double fullWidth = deviceWidth * 0.9;

  double pTheta = 75 * (pi / 180);
  // double pW = 300;
  // double pH = 250;
  double pRatio = 5 / 6; // 평행사면형 높이 / 밑변

  double pH = fullWidth / (1 / tan(pTheta) + 1 / pRatio);
  double pW = pH / pRatio;


  leftTopCorner = Offset(fullWidth - pW, deviceHeight / 2 - pH / 2);

  rightTopCorner = Offset(fullWidth, deviceHeight / 2 - pH / 2);
  leftBottomCorner = Offset(0, deviceHeight / 2 + pH / 2);
  rightBottomCorner = Offset(pW, deviceHeight / 2 + pH / 2);

  for (int i = 0; i < levelData.mapHeight + 1; i++) {
    _tileCornerOffsetList.add([]);
    for (int j = 0; j < levelData.mapWidth + 1; j++) {
      _tileCornerOffsetList[i].add(Offset(
          interDivision(start: leftTopCorner.dx, end: rightTopCorner.dx, m: j, n: levelData.mapWidth - j) -
              interDivision(start: leftBottomCorner.dx, end: leftTopCorner.dx, m: i, n: levelData.mapHeight - i) +
              (deviceWidth - fullWidth) / 2,
          interDivision(start: leftTopCorner.dy, end: leftBottomCorner.dy, m: i, n: levelData.mapHeight - i)));
    }
    ;
  }

  return _tileCornerOffsetList;
}

List<dynamic> makePersonDataList({LevelData levelData, BuildContext context}) {
  List<PersonData> personDataList = [];


  for (int i = 0; i < levelData.mapHeight; i++) {
    for (int j = 0; j < levelData.mapWidth; j++) {
      if (1 <= levelData.map[i][j] && levelData.map[i][j] <= 4) {
        for (int k = 0; k < levelData.map[i][j]; k++) {
          // personList.add(Person(x: j, y:i, idx:k, count: levelData.map[i][j],));
          personDataList.add(PersonData.fromJson({
            "x" : j, "y" : i, "idx" : k, "count" : levelData.map[i][j], "hash" :  getRandString(15), "isPlayer" : false,
          }));
        }
      }
      if (101 <= levelData.map[i][j] && levelData.map[i][j] <= 104) {
        for (int k = 0; k < levelData.map[i][j] - 100; k++) {
          // personList.add(Person(x: j, y:i, idx:k, count: levelData.map[i][j],));
          personDataList.add(PersonData.fromJson({
            "x" : j, "y" : i, "idx" : k, "count" : levelData.map[i][j] - 100, "hash" :  getRandString(15), "isPlayer" : true,
          }));
        }
      }
    }
  }

  return personDataList;
}