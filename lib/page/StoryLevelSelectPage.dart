import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/page/TestPage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import 'GamePage.dart';

class StoryLevelSelectPage extends StatefulWidget {
  int page = 0;

  StoryLevelSelectPage({this.page});

  @override
  _StoryLevelSelectPageState createState() => _StoryLevelSelectPageState(page);
}

class _StoryLevelSelectPageState extends State<StoryLevelSelectPage> {
  int _page;

  _StoryLevelSelectPageState(int page) {
    if (page == null) {
      // page = 0;

      page = 0;
    }
    _page = page;
  }

  CarouselController buttonCarouselController = CarouselController();
  int _chapter;
  List<int> _levelProcessList = List.generate(300, (index) {
    return -1;
  });

  List<bool> _isClearedList = List.generate(30, (index) {
    return false;
  });

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
      gs.audioPlayer.resume();
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    _levelProcessList = gs.getLevelProcessList();
    print(_levelProcessList[5000]);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          FadeRoute(page: HomePage()),
        );

        return true;
      },
      child: SafeArea(
        child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: CustomPaint(
                    painter: BackgroundPainter(context: context),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                        color: Colors.transparent,
                        child: Text(
                          "STORY MODE",
                          style: TextStyle(fontSize: gs.s1(), color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: levelContainerBuilder(context: context),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          FadeRoute(page: HomePage()),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
                          child: Icon(
                            Icons.undo,
                            size: gs.s1(),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     SizedBox(height: 10,),
                //     // upperBuilder(context: context),
                //     SizedBox(height: 10,),
                //     levelContainerBuilder(context: context),
                //   ],
                // )
              ],
            )),
      ),
    );
  }

  Widget upperBuilder({BuildContext context}) {
    GlobalStatus gs = context.watch<GlobalStatus>();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
              child: Icon(
                Icons.chevron_left,
                size: gs.s1(),
              )),
          SizedBox(
            width: gs.s4(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
            child: Material(
                color: Colors.transparent,
                child: Text(
                  "${String.fromCharCode(_chapter + 64)}",
                  style: TextStyle(fontSize: gs.s1()),
                  textAlign: TextAlign.center,
                )),
          ),
          SizedBox(
            width: gs.s4(),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
              child: Icon(
                Icons.chevron_right,
                size: gs.s1(),
              )),
        ],
      ),
    );
  }

  Widget levelContainerBuilder({BuildContext context}) {
    GlobalStatus gs = context.read<GlobalStatus>();
    List<dynamic> storyData = gs.storyDataJson["stories"];

    List<int> levelProcessList = gs.getLevelProcessList();
    // GridView.count(
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   crossAxisCount: 3,
    //   childAspectRatio: 1,
    //   children: List.generate(pageSize, (index) {
    //     return levelBuilder(
    //         context: context, level: pageSize * page + index + 1, levelStatus: _levelProcessList[pageSize * page + index]);
    //   }),
    // ),
    //
    return ListView(

        // height: 350,
        children: storyData.map((x) {
      return Container(
        width: gs.deviceSize.width * 0.9,
        margin: EdgeInsets.only(left: 10, bottom: 40, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Material(
            color: Colors.transparent,
            child: Text(x["time"], style: TextStyle(fontSize: gs.s4(), color: Colors.white)),
          ),
          Material(
              color: Colors.transparent,
              child: Text(
                "누적확진자 " + x["confirmedSum"] + "명",
                style: TextStyle(fontSize: gs.s5() * 0.9, color: Colors.white, fontFamily: Font.nanumBold),
              )),
          SizedBox(height: 5),
          Material(
              color: Colors.transparent,
              child: Text(
                x["description"],
                style: TextStyle(fontSize: gs.s5() * 0.9, color: Colors.white, fontFamily: Font.nanumRegular),
              )),
          SizedBox(height: 10),
          Row(
              children: x["levels"].map<Widget>((level) {
            return levelBuilder(
                realLevel: level,
                level: x["levels"].indexOf(level) + 1,
                context: context,
                levelStatus: levelProcessList[level - 1]);
          }).toList()),


        ]),
      );
    }).toList());
  }

  Widget levelBuilder({int realLevel, int level, int levelStatus, BuildContext context}) {
    GlobalStatus gs = context.watch<GlobalStatus>();
    List<bool> havingStar = [];
    havingStar.add(levelStatus % 2 == 1);
    havingStar.add(levelStatus ~/ 2 % 2 == 1);
    havingStar.add(levelStatus ~/ 4 % 2 == 1);

    int _cnt = 0;
    int _cnt2 = 0;
    return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
      return GestureDetector(
        onLongPress: () {
          if (level == 141) {
            state(() {
              _cnt = _cnt + 1;
            });
            print(_cnt);
            if (_cnt >= 5) {
              gs.unlockAllLevel();
              gs.loadSaveData();
            }
          }
          if (level == 142) {
            state(() {
              _cnt = _cnt + 1;
            });
            print(_cnt);
            if (_cnt >= 5) {
              showCouponCodeInputDialog(context: context);
            }
          }
        },
        onTap: levelStatus != -1
            ? () {
                moveToLevel(level: realLevel, context: context);
              }
            : null,
        child: Container(
            width: gs.s1() * 1.7,
            height: gs.s1() * 1.7,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 0),
            decoration: levelStatus != -1
                ? BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(1),
                    boxShadow: [
                      BoxShadow(
                        color: levelStatus == 7 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white12.withOpacity(0.5),
                        spreadRadius: levelStatus == 7 ? 3 : 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  )
                : BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey.withOpacity(0.5)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                    color: Colors.transparent,
                    child: Text(
                      level.toString(),
                      style:
                          TextStyle(fontSize: 25, color: levelStatus != -1 ? Colors.black : Colors.black.withOpacity(0.5)),
                    )),
                levelStatus != -1
                    ? Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: havingStar.map((e) {
                              return e == true
                                  ? Flexible(flex: 2, child: Icon(Icons.star, color: primaryYellow, size: gs.s3()))
                                  : Flexible(flex: 2, child: Icon(Icons.star_border, size: gs.s3()));
                            }).toList()),
                      )
                    : Container(),
              ],
            ))),
      );
    });
  }
}
