import 'dart:convert';
import 'package:dont_be_five/common/func.dart';
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
            case 31:
              showTutorialDialog(context: context, page: 9);
              break;
            case 37:
              showTutorialDialog(context: context, page: 10);
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
        child: Stack(children: [

          utilButtonContainerBuilder(context: context),
          GameMap(levelData: _currentLevelData,)]),
      ),
    );
  }
}

Widget utilButtonContainerBuilder({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context);
  return Positioned(
    // right: 20,
    top: 10 + MediaQuery.of(context).padding.top,
    child: Container(
        width: gs.deviceSize.width,
        padding: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(225, 225, 225, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
              child: RichText(
                text: TextSpan(
                  // text:
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' ',
                        style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: gs.s8())),
                    TextSpan(
                        text: gs.moveCount.toString(),
                        style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: gs.s4())),
                    TextSpan(
                        text: ' ',
                        style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: gs.s8())),
                    TextSpan(
                        text: '이동',
                        style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: gs.s5())),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pop();
                      moveToLevel(level: gs.levelData.seq, context: context, isSkipTutorial: true);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(Icons.replay),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showPauseDialog(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(Icons.reorder),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
  );
}
