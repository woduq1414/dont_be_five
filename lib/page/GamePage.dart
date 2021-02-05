import 'dart:convert';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  int level;
  bool isSkipTutorial;

  GamePage({this.level, this.isSkipTutorial});

  @override
  _GamePageState createState() => _GamePageState(level);
}

class _GamePageState extends State<GamePage> {
  int level;
  LevelData _currentLevelData;
  bool _isSkipTutorial;
  bool _isShowedTutorial = false;


  _GamePageState(this.level);

  @override
  void initState() {
    // TODO: implement initState


    setState(() {
      _isSkipTutorial = widget.isSkipTutorial;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {


      if(!_isSkipTutorial){
        if(!_isShowedTutorial){
          setState(() {
            _isShowedTutorial = true;
          });

          switch(level){
            case 1:
              showTutorialDialog(context: context, page: 1);
              break;
            case 2:
              showTutorialDialog(context: context, page: 2);
              break;
            case 4:
              showTutorialDialog(context: context, page: 3);
              break;
            case 7:
              showTutorialDialog(context: context, page: 5);
              break;
            case 13:
              showTutorialDialog(context: context, page: 7);
              break;
            case 19:
              showTutorialDialog(context: context, page: 8);
              break;
          }



        }

      }


    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    GlobalStatus gs = Provider.of<GlobalStatus>(context);



    setState(() {
      if (levelData == null) {
        // List<LevelData> levelDataList =context.select((GlobalStatus gs) => gs.levelDataList);
        GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
        List<LevelData> levelDataList = gs.levelDataList;

        if (levelDataList != null) {

          _currentLevelData = levelDataList.firstWhere((el) => el.seq == level);

        } else {}
      }
    });


    return WillPopScope(
      onWillPop: () async{

        if(!gs.isGameEnd){
          showPauseDialog(context);
        }


        return true;
      },
      child: Container(
        child: GameMap(levelData: _currentLevelData,),
      ),
    );
  }
}
