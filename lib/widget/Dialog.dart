import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/page/TestPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
                          moveToLevel(level: gs.levelData.seq, context: context, isSkipTutorial: true);
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
              Text("좌우로 넘겨보세요!", style: TextStyle(fontSize: 18),),
              CarouselSlider.builder(
                itemCount: 8,
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
          )
        ),
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
                  Row(
                    children: [
                      Text(
                        "음량 : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Builder(builder: (context2) {
                        return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                          GlobalStatus gs2 = Provider.of<GlobalStatus>(context);
                          return Slider(
                            value: _volumeValue,
                            min: 0,
                            max: 100,
                            divisions: 5,
                            label: _volumeValue.toString(),
                            onChanged: (double value) {
                              state(() {
                                _volumeValue = value;
                              });
                              gs2.volumeValue = value;
                              var storage = FlutterSecureStorage();
                              storage.write(key: "volumeValue", value: value.toString());
                            },
                          );
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 10,),
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
