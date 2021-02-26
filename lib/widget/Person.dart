
import 'dart:math';

import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Person extends StatefulWidget {

  String hash;
  dynamic personDataList;



  Person({this.hash, this.personDataList});

  @override
  _PersonState createState() {
    print(hash);
    return  _PersonState();
  }
}

class _PersonState extends State<Person> {

  String hash;

  int _x;
  int _y;
  int _idx;
  int _count;
  LevelData _levelData;

  dynamic personDataList;
  bool _isPlayer;
  List<dynamic> tileCornerOffsetList;

  double _dx = 0;
  double _dy = 0;
  double _width = 0;
  double _height = 0;


  @override
  void initState() {
    // TODO: implement initState
    hash = widget.hash;
    personDataList = widget.personDataList;


    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    GlobalStatus gs = Provider.of<GlobalStatus>(context);
    // print("rebuild?");
    // return Container();
    return personWidgetBuilder(context: context, hash: hash, personDataList: personDataList);


  }
}


Widget personWidgetBuilder({BuildContext context, String hash, dynamic personDataList}){

  int _x;
  int _y;
  int _idx;
  int _count;
  LevelData _levelData;

  // dynamic personDataList;
  bool _isPlayer;
  List<dynamic> _tileCornerOffsetList;

  double _dx = 0;
  double _dy = 0;
  double _width = 0;
  double _height = 0;

  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  // print(hash);
  PersonData targetPersonData;

  if(personDataList == null){
    personDataList = gs.personDataList;
  }

  print(personDataList.length * 10);


  try{

    // print("${hash} fuck");
    targetPersonData = personDataList.firstWhere((el) => el.hash == hash);

    // targetPersonData = personDataList.clone();
    // print(targetPersonData.toJson());
  }catch(e){

  }

  if(targetPersonData == null){
    // print("${hash} o!!!!!");
    return Container(
        key: Key(hash)
    );
  }


  _x = targetPersonData.x;
  _y = targetPersonData.y;
  _idx = targetPersonData.idx;
  // _count = targetPersonData.count;

  _isPlayer = targetPersonData.isPlayer;

  _levelData = gs.levelData;


  _tileCornerOffsetList = gs.tileCornerOffsetList;
  _count = gs.levelData.map[_y][_x];



  double oneTileWidth = _tileCornerOffsetList[_y][_x+1].dx - _tileCornerOffsetList[_y][_x].dx;
  double oneTileHeight = _tileCornerOffsetList[_y+1][_x+1].dy - _tileCornerOffsetList[_y][_x].dy;

  // tileCornerOffsetList =
  double r = min(oneTileWidth / 5, oneTileHeight / 3.4);
  if(_isPlayer == true){
    _width = min(oneTileWidth / 3, oneTileHeight / 2.5);
    _height = _width * 1.9;
    _count -= 100;



    if(_count == 1){
      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
    }else if(_count <= 10 &&_count >= 2){

      double theta = (360 / _count * _idx) * (pi / 180);;

      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 + cos(theta) * r;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2 + sin(theta) * r;
    }else{
      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
    }
  }else{
    _width = min(oneTileWidth / 3, oneTileHeight / 3.75);
    _height = _width * 1.9;


    if(_count == 1){
      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
    }else if(_count <= 10 &&_count >= 2){

      double theta = (360 / _count * _idx) * (pi / 180);;

      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 + cos(theta) * r;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2 + sin(theta) * r;
    }else{
      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
    }
  }

  return AnimatedPositioned(
    key: Key(hash),
    top: _dy - _height * 0.5,
    left: _dx - _width * 0.5,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeIn,
    child: IgnorePointer(
      child: Image.asset(
        _isPlayer ? ImagePath.player : ImagePath.person, width: _width, height: _height,
      ),
    ),
  );
}