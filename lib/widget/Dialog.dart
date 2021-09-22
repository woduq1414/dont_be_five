import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/data/GameMode.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/CustomLevelSelectPage.dart';
import 'package:dont_be_five/page/StoryLevelSelectPage.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/page/TestPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/page/MapEditPage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';

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
                    child: gs.currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY
                        ? Text(
                            "LEVEL ${level.toString()}",
                            style: TextStyle(fontSize: 35),
                          )
                        : gs.currentGameMode == GameMode.STORY_LEVEL_PLAY
                            ? Text(
                                "STORY LEVEL",
                                style: TextStyle(fontSize: 27),
                              )
                            : Text(
                                "CUSTOM LEVEL",
                                style: TextStyle(fontSize: 27),
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
                gs.currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  FadeRoute(
                                      page: LevelSelectPage(
                                    page: (level - 1) ~/ 12,
                                  )),
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
                      )
                    : gs.currentGameMode == GameMode.CUSTOM_LEVEL_EDITING
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    backToEditPage(context: context);
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
                                            child: Text("수정 화면으로",
                                                style: TextStyle(
                                                  fontSize: gs.s5(),
                                                )),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      FadeRoute(
                                          page: StoryLevelSelectPage(
                                        page: (level - 1) ~/ 12,
                                      )),
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

                          if (gs.currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY ||
                              gs.currentGameMode == GameMode.STORY_LEVEL_PLAY) {
                            moveToLevel(level: gs.levelData.seq, context: context, isSkipTutorial: true);
                          } else {
                            if (gs.currentGameMode == GameMode.CUSTOM_LEVEL_EDITING) {
                              moveToLevel(
                                  context: context,
                                  isSkipTutorial: true,
                                  isCustomLevel: true,
                                  customLevelData: gs.tempCustomLevelData);
                            } else {
                              moveToLevel(
                                  context: context,
                                  isSkipTutorial: true,
                                  isCustomLevel: true,
                                  customLevelData: gs.playingCustomLevelData);
                            }
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color.fromRGBO(200, 200, 200, 0.8)),
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
                gs.currentGameMode == GameMode.CUSTOM_LEVEL_EDITING
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // yy.dismiss();

                                publishCustomLevel(context: context);
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: primaryYellow.withOpacity(0.8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.arrow_forward, size: gs.s3()),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Text("게시하기",
                                            style: TextStyle(
                                              fontSize: gs.s5(),
                                            )),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )
                    : gs.currentGameMode == GameMode.CUSTOM_LEVEL_PLAY
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    yy.dismiss();
                                    backToCustomLevelSelectPage(context: context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: primaryYellow.withOpacity(0.8)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward, size: gs.s3()),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Text("맵 목록으로",
                                                style: TextStyle(
                                                  fontSize: gs.s5(),
                                                )),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          )
                        : gs.currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY
                            ? Row(
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
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: primaryYellow.withOpacity(0.8)),
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
                              )
                            : Container(),
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

  GameMode currentGameMode = gs.currentGameMode;

  // Map<String, dynamic> levelStarInfo = gs.getLevelStarInfo();
  var yy = YYDialog();

  return yy.build(context)
    ..barrierDismissible = true
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(0.9)
    ..widget(Stack(
      children: [
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
                    child: gs.currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY
                        ? Text(
                            "LEVEL ${level.toString()}",
                            style: TextStyle(fontSize: 35),
                          )
                        : Text(
                            "CUSTOM LEVEL",
                            style: TextStyle(fontSize: 27),
                          )),
                SizedBox(
                  height: 15,
                ),
                buildStarInfo(context),
                SizedBox(
                  height: 15,
                ),
                gs.currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  FadeRoute(
                                      page: LevelSelectPage(
                                    page: (level - 1) ~/ 12,
                                  )),
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
                      )
                    : gs.currentGameMode == GameMode.CUSTOM_LEVEL_EDITING
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    backToEditPage(context: context);
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
                                            child: Text("수정 화면으로",
                                                style: TextStyle(
                                                  fontSize: gs.s5(),
                                                )),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    yy.dismiss();
                                    if (gs.currentGameMode == GameMode.CUSTOM_LEVEL_PLAY) {
                                      backToCustomLevelSelectPage(context: context);
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        FadeRoute(
                                            page: StoryLevelSelectPage(
                                          page: (level - 1) ~/ 12,
                                        )),
                                      );
                                    }
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
                                            child: Text("맵 목록으로",
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
        Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                showTutorialDialog(page: 1, context: context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding: EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                  color: Colors.grey.withOpacity(0.7),
                ),
                child: Text(
                  "?",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ))
      ],
    ))
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
  Map<String, dynamic> levelStarInfo = gs.getLevelStarInfo(psc: gs.levelData.pStarCondition);
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

YYDialog showTutorialDialog({int page, BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  CarouselController buttonCarouselController = CarouselController();
  var yy = YYDialog();

  return yy.build(context)
    ..barrierDismissible = true
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(1)
    ..duration = Duration(milliseconds: 400)
    ..widget(Stack(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
            child: Column(
              children: [
                Text(
                  "좌우로 넘겨보세요!",
                  style: TextStyle(fontSize: 18),
                ),
                CarouselSlider.builder(
                  itemCount: 10,
                  carouselController: buttonCarouselController,
                  itemBuilder: (BuildContext context, int itemIndex, int _) => Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        ImagePath.getTutorialImagePath(itemIndex + 1),
                        height: MediaQuery.of(context).size.height * 0.7,
                      )
                    ],
                  )),
                  options: CarouselOptions(
                    // height: gs.deviceSize.height * 0.,
                    autoPlay: false,
                    reverse: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                    // height: ,
                    initialPage: page - 1,
                  ),
                ),
              ],
            )),
        Positioned.fill(
          left: 15,
          right: 15,
          bottom: 7,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_back, size: gs.s2()),
                  SizedBox(
                    width: 5,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text("돌아가기",
                        style: TextStyle(
                          fontSize: gs.s4(),
                        )),
                  ),
                ],
              ),
              backgroundColor: Colors.grey.withOpacity(0.7),
              onTap: () {
                yy.dismiss();
              },
            ),
          ),
        ),
      ],
    ))
    ..animatedFunc = (child, animation) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            Tween<double>(begin: -50.0, end: 0)
                .animate(
                  CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                )
                .value,
          )
          ..scale(
            Tween<double>(begin: 0, end: 1.0)
                .animate(
                  CurvedAnimation(curve: Curves.easeOut, parent: animation),
                )
                .value,
          ),
        child: child,
      );
    }
    ..show();
}

YYDialog showSettingDialog({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

  var yy = YYDialog();

  var _volumeValue = gs.volumeValue;
  var _isVibrate = gs.isVibrate;

  return yy.build(context)
    ..barrierDismissible = true
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(1)
    // ..duration = Duration(milliseconds: 800)

    ..widget(Stack(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Row(
                  //   children: [
                  //     Text(
                  //       "음량 : ",
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //     Builder(builder: (context2) {
                  //       return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                  //         GlobalStatus gs2 = Provider.of<GlobalStatus>(context);
                  //         return Slider(
                  //           value: _volumeValue,
                  //           min: 0,
                  //           max: 100,
                  //           divisions: 5,
                  //           label: _volumeValue.toString(),
                  //           onChanged: (double value) {
                  //             state(() {
                  //               _volumeValue = value;
                  //             });
                  //             gs2.volumeValue = value;
                  //             var storage = FlutterSecureStorage();
                  //             storage.write(key: "volumeValue", value: value.toString());
                  //           },
                  //         );
                  //       });
                  //     }),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "진동 : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Builder(builder: (context2) {
                        return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                          GlobalStatus gs2 = Provider.of<GlobalStatus>(context);
                          return Switch(
                            value: _isVibrate == "true" ? true : false,
                            onChanged: (value) {
                              state(() {
                                _isVibrate = value == true ? "true" : "false";
                              });
                              gs2.isVibrate = value == true ? "true" : "false";
                              var storage = FlutterSecureStorage();
                              storage.write(key: "isVibrate", value: value.toString());
                            },
                          );
                        });
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "버전 : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      FutureBuilder(
                          future: rootBundle.loadString("pubspec.yaml"),
                          builder: (context, snapshot) {
                            String version = "Unknown";
                            if (snapshot.hasData) {
                              var yaml = loadYaml(snapshot.data);
                              version = yaml["version"];
                            }

                            return Container(
                              child: Text(
                                '$version',
                                style: TextStyle(fontSize: gs.s5()),
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "닉네임 : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                          backgroundColor: Color.fromRGBO(220, 220, 220, 0.7),
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              child: Text("설정", style: TextStyle(fontSize: gs.s5()))),
                          onTap: () {
                            showSetNicknameDialog(context: context);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        backgroundColor: Color.fromRGBO(220, 220, 220, 0.7),
                        onTap: () {
                          LaunchReview.launch(
                            androidAppId: "com.aperture.dont_be_five",
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: Text(
                              "별점 평가/리뷰 하기",
                              style: TextStyle(fontSize: gs.s5()),
                            )),
                      )
                    ],
                  )
                ])),
      ],
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

void showCustomConfirmDialog(
    {BuildContext context,
    String title,
    String content,
    String cancelButtonText,
    String confirmButtonText,
    var cancelButtonAction,
    var confirmButtonAction}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        contentPadding: EdgeInsets.only(top: 0.0),
        titlePadding: EdgeInsets.all(0),
        buttonPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        actionsOverflowButtonSpacing: 0,
//        buttonPadding : EdgeInsets.all(0),
        content: Container(
//          height : 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
//                      height: 25,
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 10),
                    if (content != null)
                      Container(
                        margin: EdgeInsets.only(bottom: 10, left: 5),
                        child: Text(
                          content,
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
              Container(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    cancelButtonText != null
                        ? Expanded(
                            child: Material(
                              color: Color.fromRGBO(190, 190, 190, 1),
                              child: InkWell(
                                onTap: cancelButtonAction,
                                child: Container(
                                  height: 35,
                                  child: Center(
                                    child: Text(cancelButtonText),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: Material(
                        color: primaryYellow,
                        child: InkWell(
                          onTap: confirmButtonAction,
                          child: Container(
                            height: 35,
                            child: Center(
                              child: Text(confirmButtonText),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        actions: <Widget>[],
      );
    },
  );
}

void backToEditPage({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  Navigator.pop(context);
  // Navigator.pop(context);
  Navigator.pushReplacement(
    context,
    FadeRoute(page: MapEditPage(tempLevelData: gs.tempCustomLevelData)),
  );

  return;
}

void backToCustomLevelSelectPage({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  // Navigator.pop(context);
  // Navigator.pop(context);
  Navigator.pushReplacement(
    context,
    FadeRoute(page: CustomLevelSelectPage()),
  );

  return;
}

dynamic showCouponCodeInputDialog({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  var yy = YYDialog();

  return yy.build(context)
    ..barrierDismissible = true
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(1)
    ..duration = Duration(milliseconds: 400)
    ..widget(Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          // width: gs.deviceS,

          child: Container(
              // padding: EdgeInsets.symmetric(),
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text("코드", style: TextStyle(fontSize: gs.s3())),
              SizedBox(
                height: 5,
              ),
              Builder(builder: (context) {
                final myController = TextEditingController(
                    text:
                        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}");

                String title = "";

                bool _isPublic = true;

                bool _isUploading = false;

                return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '코드',
                            ),
                            onChanged: (x) {},
                            controller: myController,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: CustomButton(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("확인",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                            backgroundColor: primaryYellow,
                            onTap: () {
                              String text = myController.text;

                              if (text == "4pErTuRe_F0r3vER") {
                                gs.cheat();
                                gs.loadSaveData();
                              }

                              print(text);

                              yy.dismiss();
                            }),
                      ),
                    ],
                  );
                });
              }),
            ],
          )),
        )
      ],
    ))
    ..animatedFunc = (child, animation) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            Tween<double>(begin: -50.0, end: 0)
                .animate(
                  CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                )
                .value,
          )
          ..scale(
            Tween<double>(begin: 0, end: 1.0)
                .animate(
                  CurvedAnimation(curve: Curves.easeOut, parent: animation),
                )
                .value,
          ),
        child: child,
      );
    }
    ..show();
}

dynamic showSetNicknameDialog({BuildContext context}) async {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  var yy = YYDialog();
  var storage = FlutterSecureStorage();

  String nickname = await storage.read(key: "nickname");
  if (nickname == null) {
    nickname = "익명";
  }
  return yy.build(context)
    ..barrierDismissible = false
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(1)
    ..duration = Duration(milliseconds: 400)
    ..dismissCallBack = () async {}
    ..widget(WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // width: gs.deviceS,

            child: Container(
                // padding: EdgeInsets.symmetric(),
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("닉네임", style: TextStyle(fontSize: gs.s3())),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "커스텀 맵의 제작자 닉네임으로 다른 사람들에게 공개됩니다.",
                  style: TextStyle(
                    fontSize: gs.s5(),
                  ),
                  textAlign: TextAlign.center,
                ),
                Builder(builder: (context) {
                  final myController = TextEditingController(text: nickname);
                  String title = "";

                  return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '닉네임',
                              ),
                              onChanged: (x) {},
                              controller: myController,
                            )
                          ],
                        ),
                        Text(
                          "※ 설정 창에서 다시 설정할 수 있습니다.",
                          style: TextStyle(
                            fontSize: gs.s5(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: CustomButton(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.check, size: gs.s3()),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: Text("확인",
                                        style: TextStyle(
                                          fontSize: gs.s5(),
                                        )),
                                  ),
                                ],
                              ),
                              backgroundColor: primaryYellow,
                              onTap: () async {
                                String text = myController.text.replaceAll(" ", "");

                                var storage = FlutterSecureStorage();

                                if (text.length >= 1 && text.length <= 10) {
                                  storage.write(key: "nickname", value: text);
                                  yy.dismiss();
                                } else {
                                  showCustomToast("공백이 없는 1자 이상 10자 이하의 닉네임을 입력해주세요.", ToastType.small);
                                }
                              }),
                        ),
                      ],
                    );
                  });
                }),
              ],
            )),
          )
        ],
      ),
    ))
    ..animatedFunc = (child, animation) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            Tween<double>(begin: -50.0, end: 0)
                .animate(
                  CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                )
                .value,
          )
          ..scale(
            Tween<double>(begin: 0, end: 1.0)
                .animate(
                  CurvedAnimation(curve: Curves.easeOut, parent: animation),
                )
                .value,
          ),
        child: child,
      );
    }
    ..show();
}
