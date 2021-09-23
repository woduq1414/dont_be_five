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
import 'package:dont_be_five/page/NewHomePage.dart';
import 'package:dont_be_five/page/TestPage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/BackgroundScreen.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/LevelSquare.dart';
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


    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          FadeRoute(page: NewHomePage()),
        );

        return true;
      },
      child: SafeArea(
        child: BackgroundScreen(
            // color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: <Widget>[
                  // SizedBox.expand(
                  //   child: CustomPaint(
                  //     painter: BackgroundPainter(context: context),
                  //   ),
                  // ),

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
                            FadeRoute(page: NewHomePage()),
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
                        height: 25,
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
              ),
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        width: gs.deviceSize.width * 0.9,
        margin: EdgeInsets.only(left: 10, bottom: 40, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Material(
            color: Colors.transparent,
            child: Text(x["time"], style: TextStyle(fontSize: gs.s4(), color: primaryPurpleDark)),
          ),
          Row(
            children: [
              Icon(Icons.coronavirus, color: primaryPurpleDark , size : gs.s4()),
              SizedBox(width: 3,),
              Material(
                  color: Colors.transparent,
                  child: Text(
                    "월 확진자 " + x["confirmedSum"] + "명",
                    style: TextStyle(fontSize: gs.s5() * 0.9, color: primaryPurpleDark, fontFamily: Font.nanumBold),
                  )),
            ],
          ),
          SizedBox(height: 5),
          Material(
              color: Colors.transparent,
              child: Text(
                x["description"],
                style: TextStyle(fontSize: gs.s5() * 0.9, color: primaryPurpleDark, fontFamily: Font.nanumRegular),
              )),
          SizedBox(height: 10),
          Row(
              children: x["levels"].map<Widget>((level) {
            return Container(
              width: gs.s1() * 2.1,
              height: gs.s1() * 2.1,
              child: levelBuilder(
                  realLevel: level,
                  level: x["levels"].indexOf(level) + 1,
                  context: context,
                  levelStatus: levelProcessList[level - 1]),
            );
          }).toList()),


        ]),
      );
    }).toList());
  }


}
