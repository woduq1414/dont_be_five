import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:provider/provider.dart';

YYDialog showGoalDialog(BuildContext context) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  int level = gs.levelData.seq;

  var yy = YYDialog();

  return yy.build(context)
    ..barrierDismissible = false
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(0.9)
    ..widget(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                    color: Colors.transparent,
                    child: Text(
                      "LEVEL ${level.toString()}",
                      style: TextStyle(fontSize: 35),
                    )),
                Material(
                    color: Colors.transparent,
                    child: Text(
                      "COMPLETE!",
                      style: TextStyle(fontSize: 35),
                    )),
                SizedBox(
                  height: 15,
                ),
                buildStarInfo(context),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            FadeRoute(page: LevelSelectPage()),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color.fromRGBO(200, 200, 200, 0.8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.arrow_back, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("레벨 선택으로",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // yy.dismiss();
                          moveToLevel(level: gs.levelData.seq, context: context);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)), color: Color.fromRGBO(200, 200, 200, 0.8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.replay, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("다시하기",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // yy.dismiss();
                          moveToLevel(level: gs.levelData.seq + 1, context: context);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)), color: primaryYellow.withOpacity(0.8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.arrow_forward, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("다음 레벨로",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ))),
      ),
    )
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog showPauseDialog(BuildContext context) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  int level = gs.levelData.seq;
  Map<String, dynamic> levelStarInfo = gs.getLevelStarInfo();
  var yy = YYDialog();

  return yy.build(context)
    ..barrierDismissible = true
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(0.9)
    ..widget(
      Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                  color: Colors.transparent,
                  child: Text(
                    "LEVEL ${level.toString()}",
                    style: TextStyle(fontSize: 35),
                  )),
              SizedBox(
                height: 15,
              ),
              buildStarInfo(context),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          FadeRoute(page: LevelSelectPage()),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Color.fromRGBO(200, 200, 200, 0.8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_back, size: gs.s3()),
                              SizedBox(
                                width: 5,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Text("레벨 선택으로",
                                    style: TextStyle(
                                      fontSize: gs.s5(),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        yy.dismiss();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: primaryYellow.withOpacity(0.8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward, size: gs.s3()),
                              SizedBox(
                                width: 5,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Text("계속하기",
                                    style: TextStyle(
                                      fontSize: gs.s5(),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ))),
    )
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

Widget buildStarInfo(BuildContext context) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  int level = gs.levelData.seq;
  Map<String, dynamic> levelStarInfo = gs.getLevelStarInfo();
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: levelStarInfo.keys.map<Widget>((cond) {
        return Row(
          children: <Widget>[
            levelStarInfo[cond]
                ? Icon(
                    Icons.star,
                    size: 40,
                    color: primaryYellow,
                  )
                : Icon(
                    Icons.star_border,
                    size: 40,
                  ),
            Flexible(
              child: Center(
                child: Material(
                    color: Colors.transparent,
                    child: Text(
                      cond,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
              ),
            )
          ],
        );
      }).toList());
}

