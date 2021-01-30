
import 'dart:math';

import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Goal extends StatefulWidget {






  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {



  int _x;
  int _y;

  double _dx;
  double _dy;

  LevelData _levelData;
  List<dynamic> _tileCornerOffsetList;

  double _width;
  double _height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  Widget build(BuildContext context) {

    GlobalStatus gs = context.watch<GlobalStatus>();


    setState(() {

      _x = gs.goalTile.x;
      _y = gs.goalTile.y;



      _levelData = gs.levelData;
      _tileCornerOffsetList = gs.tileCornerOffsetList;


      print("rebuild!!!!!!!");

      // tileCornerOffsetList =

      _width = 27;
      _height = 50;


      _dx = (_tileCornerOffsetList[_y][_x].dx +  _tileCornerOffsetList[_y+1][_x+1].dx) / 2 ;
      _dy = (_tileCornerOffsetList[_y][_x].dy +  _tileCornerOffsetList[_y+1][_x+1].dy) / 2;
    });


    return AnimatedPositioned(
      top: _dy - _height * 0.5,
      left: _dx - _width * 0.5,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      child: IgnorePointer(
        child: Image.asset(
          ImagePath.goal, width: _width, height: _height,
        ),
      ),
    );
  }
}
