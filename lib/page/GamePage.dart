import 'dart:convert';
import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/firebase.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/data/GameMode.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Loading.dart';
import 'package:dont_be_five/widget/Toast.dart';
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
      if (!_isSkipTutorial) {
        if (!_isShowedTutorial) {
          setState(() {
            _isShowedTutorial = true;
          });

          switch (level) {
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
                      margin: EdgeInsets.only(top: 45, left: 5, right: 5),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white.withOpacity(0.7)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [0, 1, 2].map((x) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: primaryYellow,
                                  size: gs.s3(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  gs.getLevelStarInfo(getOnlyStr: true)[x],
                                  style: TextStyle(fontSize: gs.s4(), fontFamily: Font.light),
                                  maxLines: 3,
                                  softWrap: true,
                                )),
                              ],
                            );
                          }).toList())),
                  duration: Duration(milliseconds: 3000));

              if(gs.currentGameMode == GameMode.STORY_LEVEL_PLAY){

                showCustomToast("<${gs.levelPersonLimit}인 이상 집합 금지>룰이 적용되었습니다!", ToastType.small);
              }
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
        if (isCustomMap == false) {
          // List<LevelData> levelDataList =context.select((GlobalStatus gs) => gs.levelDataList);
          GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
          List<LevelData> levelDataList = gs.levelDataList;

          if (levelDataList != null) {
            _currentLevelData = levelDataList.firstWhere((el) => el.seq == level);
          } else {}
        } else {
          _currentLevelData = customLevelData;
        }
      }
    });

    return LoadingModal(
      child: WillPopScope(
        onWillPop: () async {
          if (!gs.isGameCleared) {
            showPauseDialog(context);
          }

          return true;
        },
        child: Container(
          child: Stack(children: [
            GameMap(
              levelData: _currentLevelData,
            ),
            utilButtonContainerBuilder(context: context),
          ]),
        ),
      ),
    );
  }

  Widget buildStarConditionSquare({BuildContext context, bool isAchieved = false, String starConditionText = "이동 25"}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    return Container(
      width: gs.s1() * 1.3,
      height: gs.s1() * 1.3,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isAchieved == true
              ? Icon(Icons.star, color: Colors.yellowAccent.withOpacity(0.8), size: gs.s3())
              : Icon(Icons.star, color: Colors.white.withOpacity(0.8), size: gs.s3()),
          SizedBox(
            height: 3,
          ),
          Text(starConditionText,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: gs.s7() * 1.2,
                  fontFamily: Font.nanumLight))
        ],
      ),
    );
  }

  String getShortStarConditionText(String sc) {
    List<String> condList = sc.split("&").map((x) {
      return x.trim();
    }).toList();

    String cond = condList[0];
    String stopWord = cond.split(" ")[0];
    String str = "";
    switch (stopWord) {
      case "clear":
        str += "클리어";

        break;
      case "move":
        str += "이동 ${cond.split(" ")[1]}";

        break;
      case "no":
        String target = cond.split(" ")[1];
        if (target == "item") {
          str += "아이템 X";
        }

        List<ItemData> itemList = [ItemData.isolate, ItemData.release, ItemData.vaccine, ItemData.diagonal];
        for (ItemData item in itemList) {
          if (target == item.name) {
            str += "${item.caption} X";
          }
        }

        break;

      case "limit":
        String target = cond.split(" ")[1];
        int num = int.parse(cond.split(" ")[2]);

        if (target == "item") {
          str += "아이템 ${num}";
        }

        List<ItemData> itemList = [ItemData.isolate, ItemData.release, ItemData.vaccine, ItemData.diagonal];
        for (ItemData item in itemList) {
          if (target == item.name) {
            str += "${item.caption} ${num}";
          }
        }
    }
    return str;
  }

  Widget buildStarConditionSquareList({BuildContext context}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    int level = gs.levelData.seq;
    List<String> pStarCondition = gs.levelData.pStarCondition;
    List<bool> isAchievedList = gs.getCurrentStarAchievedStatus();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          buildStarConditionSquare(
              context: context,
              starConditionText: getShortStarConditionText(pStarCondition[0]),
              isAchieved: isAchievedList[0]),
          buildStarConditionSquare(
              context: context,
              starConditionText: getShortStarConditionText(pStarCondition[1]),
              isAchieved: isAchievedList[1]),
          buildStarConditionSquare(
              context: context,
              starConditionText: getShortStarConditionText(pStarCondition[2]),
              isAchieved: isAchievedList[2]),
        ],
      ),
    );
  }

  Widget buildRestartButton({BuildContext context}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pop();

        if (isCustomMap) {
          moveToLevel(context: context, isSkipTutorial: true, isCustomLevel: true, customLevelData: customLevelData);
        } else {
          moveToLevel(level: gs.levelData.seq, context: context, isSkipTutorial: true);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.replay,
          color: Colors.black,
          size: gs.s4(),
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
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                      margin: EdgeInsets.only(left: 23),
                      decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(gs.moveCount.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontSize: gs.s3() * 1.2,
                                  fontFamily: Font.nanumBold)),
                          SizedBox(
                            height: 1,
                          ),
                          Text("이동",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontSize: gs.s6() * 1.1,
                                  fontFamily: Font.nanumLight)),
                        ],
                      )),
                  buildRestartButton(context: context)
                ],
              ),

              buildStarConditionSquareList(context: context)
              // Container(
              //   margin: EdgeInsets.only(right: 10),
              //   child: Row(
              //     children: <Widget>[
              //       GestureDetector(
              //         onTap: () {
              //           // Navigator.of(context).pop();
              //
              //           if (isCustomMap) {
              //             moveToLevel(
              //                 context: context, isSkipTutorial: true, isCustomLevel: true, customLevelData: customLevelData);
              //           } else {
              //             moveToLevel(level: gs.levelData.seq, context: context, isSkipTutorial: true);
              //           }
              //         },
              //         child: Container(
              //           margin: EdgeInsets.symmetric(horizontal: 2),
              //           padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              //           decoration: BoxDecoration(
              //               color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
              //           child: Icon(Icons.replay),
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           showPauseDialog(context);
              //         },
              //         child: Container(
              //           margin: EdgeInsets.symmetric(horizontal: 2),
              //           padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              //           decoration: BoxDecoration(
              //               color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
              //           child: Icon(Icons.reorder),
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          )),
    );
  }
}
