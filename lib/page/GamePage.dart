import 'dart:convert';
import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/firebase.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Loading.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  int level;
  bool isSkipTutorial;

  bool isCustomMap;
  LevelData customLevelData;


  GamePage({this.level, this.isSkipTutorial, this.isCustomMap, this.customLevelData});

  @override
  _GamePageState createState() => _GamePageState(level);
}

class _GamePageState extends State<GamePage> {
  int level;
  LevelData _currentLevelData;
  bool _isSkipTutorial;
  bool _isShowedTutorial = false;
  bool isCustomMap;
  LevelData customLevelData;

  _GamePageState(this.level);

  @override
  void initState() {
    // TODO: implement initState

    AdManager.showBanner();


    setState(() {
      isCustomMap = widget.isCustomMap != null ? widget.isCustomMap : false;
      customLevelData = widget.customLevelData;

      _isSkipTutorial = widget.isSkipTutorial;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
      gs.isEditMode = false;
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

            default:
              showToastWidget(
                  Container(
                      height: 150,
                      margin: EdgeInsets.only(top:45, left: 5, right: 5),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),

                      decoration: BoxDecoration(
                          borderRadius : BorderRadius.all(Radius.circular(5)),
                          color: Colors.white.withOpacity(0.7)
                      ),
                      child : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [0,1,2].map((x){
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Icon(Icons.star, color : primaryYellow,  size: gs.s3(),),
                              SizedBox(width: 5,),
                              Expanded(child: Text(gs.getLevelStarInfo(getOnlyStr: true)[x], style: TextStyle(fontSize: gs.s4(), fontFamily: Font.light), maxLines: 3, softWrap: true,)),
                            ],);
                          }).toList()

                      )
                  ),
                  duration: Duration(milliseconds: 3000)
              );
              break;
          }



        }



      }


    });



    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    GlobalStatus gs = Provider.of<GlobalStatus>(context);



    setState(() {
      if (levelData == null) {

        if(isCustomMap == false){
          // List<LevelData> levelDataList =context.select((GlobalStatus gs) => gs.levelDataList);
          GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
          List<LevelData> levelDataList = gs.levelDataList;

          if (levelDataList != null) {

            _currentLevelData = levelDataList.firstWhere((el) => el.seq == level);

          } else {}
        }else{
          _currentLevelData = customLevelData;
        }



      }
    });


    return LoadingModal(
      child: WillPopScope(
        onWillPop: () async{

          if(!gs.isGameCleared){
            showPauseDialog(context);
          }


          return true;
        },
        child: Container(
          child: Stack(children: [
            GameMap(levelData: _currentLevelData,),
            utilButtonContainerBuilder(context: context),
            ]),
        ),
      ),
    );
  }


  Widget utilButtonContainerBuilder({BuildContext context}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
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

                        if(isCustomMap){
                          moveToLevel(context: context, isSkipTutorial: true, isCustomLevel: true, customLevelData: customLevelData);
                        }else{
                          moveToLevel(level: gs.levelData.seq, context: context, isSkipTutorial: true);
                        }

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
}

