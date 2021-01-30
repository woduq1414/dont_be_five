
import 'dart:math';

import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Person extends StatefulWidget {

  String hash;



  Person({this.hash});

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {

  String hash;

  int _x;
  int _y;
  int _idx;
  int _count;
  LevelData _levelData;
  bool _isPlayer;
  List<dynamic> _tileCornerOffsetList;

  double _dx = 0;
  double _dy = 0;
  double _width = 0;
  double _height = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hash = widget.hash;

  }

  @override
  Widget build(BuildContext context) {

    GlobalStatus gs = context.watch<GlobalStatus>();

    PersonData targetPersonData;
    try{
      targetPersonData = gs.personDataList.firstWhere((el) => el.hash == hash);
    }catch(e){

    }

    if(targetPersonData == null){
      return Container();
    }


    setState(() {

      _x = targetPersonData.x;
      _y = targetPersonData.y;
      _idx = targetPersonData.idx;
      _count = targetPersonData.count;

      _isPlayer = targetPersonData.isPlayer;

      _levelData = gs.levelData;
      _tileCornerOffsetList = gs.tileCornerOffsetList;
      _count = gs.levelData.map[_y][_x];



      print("rebuild!!!!!!!");

      // tileCornerOffsetList =

      if(_isPlayer == true){
        _width = 27;
        _height = 50;
        _count -= 100;



        if(_count == 1){
          _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
          _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
        }else if(_count <= 10 &&_count >= 2){

          double theta = (360 / _count * _idx) * (pi / 180);;

          _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 + cos(theta) * 15;
          _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2 + sin(theta) * 15;
        }else{
          _dx = _tileCornerOffsetList[_y][_x].dx;
          _dy = _tileCornerOffsetList[_y][_x].dy;
        }
      }else{
        _width = 27;
        _height = 50;



        if(_count == 1){
          _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
          _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
        }else if(_count <= 10 &&_count >= 2){

          double theta = (360 / _count * _idx) * (pi / 180);;

          _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 + cos(theta) * 15;
          _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2 + sin(theta) * 15;
        }else{
          _dx = _tileCornerOffsetList[_y][_x].dx;
          _dy = _tileCornerOffsetList[_y][_x].dy;
        }
      }


    });


    return AnimatedPositioned(
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
}
