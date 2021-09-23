import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/firebase.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/GameMode.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/CustomLevelSelectPage.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/page/MapEditPage.dart';
import 'package:dont_be_five/page/NewHomePage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:games_services/games_services.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

import 'StoryLevelSelectPage.dart';

// import 'GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  LevelData _levelData = LevelData.fromJson({
    "seq": 9999,
    "mapWidth": 5,
    "mapHeight": 5,
    "map": [
      [-1, -1, -1, -1, -1],
      [-1, -1, 1, -1, -1],
      [-1, 1, 101, 1, -1],
      [-1, -1, 1, -1, -1],
      [-1, -1, -1, -1, -1]
    ],
    "pStarCondition": ["clear", "move 15 & clear", "no isolate & clear"]
  });

  List<PersonData> _personDataList;
  List<dynamic> _tileCornerOffsetList;

  AnimationController _animationController;
  Animation _animation;

  AnimationController _animationController2;
  Animation _animation2;

  DateTime currentBackPressTime;
  List<Widget> _cachedPersonBuilder = [Container()];

  bool _personLoaded = false;

  bool _isCustomMapAvailable = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  test() async {
    // SigninResult result =  await PlayGames.signIn();
  }

  void initState() {
    // TODO: implement initState
    _personLoaded = false;
    AdManager.init();
    AdManager.showBanner();

    // GamesServices.signIn();
    // test();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.repeat(reverse: true);
    _animation = Tween(
      begin: 2.0,
      end: 6.0,
    ).animate(new CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc))
      ..addListener(() {
        setState(() {});
      });

    _animationController2 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController2.repeat(reverse: true);
    _animation2 = Tween(
      begin: 0,
      end: 10.0,
    ).animate(new CurvedAnimation(parent: _animationController2, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    // _animationController.duration

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

        // print(gs.getLastUnlockedLevel());
        // if(gs.getLastUnlockedLevel() >= 19){
        //   _isCustomMapAvailable = true;
        // }else{
        //   _isCustomMapAvailable = false;
        // }

        _tileCornerOffsetList = calcTileCornerOffsetList(levelData: _levelData, context: context);
        gs.tileCornerOffsetList = _tileCornerOffsetList;

        // _levelData =

        gs.levelData = _levelData;
        // gs.personDataList = _personDataList;
        gs.deviceSize = MediaQuery.of(context).size;

        _personDataList = makePersonDataList(levelData: _levelData, context: context);
        gs.personDataList = _personDataList;
        print("sdjlk");
        _cachedPersonBuilder = personBuilder(context: context, pdl: _personDataList, tcol: _tileCornerOffsetList);
        gs.notify();
        print(_levelData);

        print(_cachedPersonBuilder);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);
    // print(gs);
    gs.deviceSize = MediaQuery.of(context).size;
    gs.isHomePage = true;
    // print(_animation.value);

    // gs.levelData = _levelData;
    // gs.tileCornerOffsetList = _tileCornerOffsetList;

    // if (_personLoaded == false) {
    //   // gs.personDataList = _personDataList;
    //   // _personDataList = makePersonDataList(levelData: _levelData, context: context);
    //   print("sdjlk");
    //   // _cachedPersonBuilder = personBuilder(context: context, pdl: _personDataList);
    //   setState(() {
    //
    //     _personLoaded = true;
    //     print(_cachedPersonBuilder);
    //   });
    // }

    // print(_cachedPersonBuilder);

    // return Container();

    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 1)) {
          currentBackPressTime = now;
          showCustomToast("한 번 더 뒤로가기를 누르면 종료됩니다", ToastType.small);
          return Future.value(false);
        }

        exit(1);

        return Future.value(true);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // print("DDDDDDDDDDd");
          Navigator.pushReplacement(
            context,
            // FadeRoute(page: LevelSelectPage()),
            FadeRoute(page: NewHomePage()),
          );
        },
        child: IgnorePointer(
          child: SafeArea(
            child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    FutureBuilder(
                        future: rootBundle.loadString("pubspec.yaml"),
                        builder: (context, snapshot) {
                          GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
                          String version = "Unknown";
                          if (snapshot.hasData) {
                            var yaml = loadYaml(snapshot.data);
                            version = yaml["version"];
                            gs.appVersion = yaml["version"];
                          }

                          return Container();
                        }),

                    SizedBox.expand(
                      child: CustomPaint(
                        painter: BackgroundPainter(context: context),
                      ),
                    ),
                    _tileCornerOffsetList != null
                        ? SizedBox.expand(
                            child: CanvasTouchDetector(
                              builder: (context) => CustomPaint(
                                painter: MapPainter(
                                    levelData: _levelData, tileCornerOffsetList: _tileCornerOffsetList, context: context),
                              ),
                            ),
                          )
                        : Container(),

                    // Positioned.fill(
                    //   bottom: 0,
                    //   child: Align(
                    //       alignment: Alignment.bottomCenter,
                    //       child: Image.asset(ImagePath.homeMap, height: gs.deviceSize.height * 0.58,)),
                    // ),

                    ..._tileCornerOffsetList != null ? _cachedPersonBuilder : [Container()],
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03 + _animation.value,
                          ),
                          Image.asset(
                            ImagePath.titleLogo,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      bottom: 120,
                      left: 15,
                      right: 15,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.play_arrow,
                                size: gs.s2(),
                                color: Colors.white.withOpacity(1.0),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text("탭 하여 시작",
                                      style: TextStyle(
                                          fontSize: gs.s3(),
                                          color: Colors.white.withOpacity(0.9),
                                          shadows: <Shadow>[
                                            Shadow(
                                                offset: Offset(0, 0),
                                                blurRadius: _animation2.value * 0.6,
                                                color: Colors.white.withOpacity(0.8))
                                          ])),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          onTap: () {
                            // moveToLevel(level: 23 , context: context);
                            // return;

                            // Navigator.pushReplacement(
                            //   context,
                            //   // FadeRoute(page: LevelSelectPage()),
                            //   FadeRoute(page: LevelSelectPage(page: 0)),
                            // );
                          },
                        ),
                      ),
                    ),

                    // Positioned.fill(
                    //   bottom: 180,
                    //   left: 15,
                    //   right: 15,
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: CustomButton(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Icon(Icons.play_arrow, size: gs.s2()),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Material(
                    //             color: Colors.transparent,
                    //             child: Text("단계모드",
                    //                 style: TextStyle(
                    //                   fontSize: gs.s4(),
                    //                 )),
                    //           ),
                    //         ],
                    //       ),
                    //       backgroundColor: Colors.white70.withOpacity(0.9),
                    //       onTap: () {
                    //         // moveToLevel(level: 23 , context: context);
                    //         // return;
                    //
                    //         Navigator.pushReplacement(
                    //           context,
                    //           // FadeRoute(page: LevelSelectPage()),
                    //           FadeRoute(page: LevelSelectPage(page:0)),
                    //
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Positioned.fill(
                    //   bottom: 130,
                    //   left: 15,
                    //   right: 15,
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: CustomButton(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Icon(Icons.menu_book, size: gs.s2()),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Material(
                    //             color: Colors.transparent,
                    //             child: Text("스토리모드",
                    //                 style: TextStyle(
                    //                   fontSize: gs.s4(),
                    //                 )),
                    //           ),
                    //         ],
                    //       ),
                    //       backgroundColor: Colors.white70.withOpacity(0.9),
                    //       onTap: () {
                    //         // moveToLevel(level: 23 , context: context);
                    //         // return;
                    //
                    //         Navigator.pushReplacement(
                    //           context,
                    //           // FadeRoute(page: LevelSelectPage()),
                    //           FadeRoute(page: StoryLevelSelectPage()),
                    //
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Positioned.fill(
                    //   bottom: 80,
                    //   left: 15,
                    //   right: 15,
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: CustomButton(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Icon(Icons.construction, size: gs.s2()),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           // Material(
                    //           //   color: Colors.transparent,
                    //           //   child: Text("(Beta) ",
                    //           //       style: TextStyle(
                    //           //         fontSize: gs.s6() * 1.1,
                    //           //       )),
                    //           // ),
                    //           Material(
                    //             color: Colors.transparent,
                    //             child: Text("메이커스센터",
                    //                 style: TextStyle(
                    //                   fontSize: gs.s4(),
                    //                 )),
                    //           ),
                    //
                    //         ],
                    //       ),
                    //       backgroundColor: gs.isCustomMapAvailable ? Colors.white70.withOpacity(0.9) : Colors.grey.withOpacity(0.8),
                    //       onTap: gs.isCustomMapAvailable ? () {
                    //         // moveToLevel(level: 23 , context: context);
                    //         // return;
                    //
                    //         Navigator.pushReplacement(
                    //           context,
                    //           FadeRoute(page: CustomLevelSelectPage()),
                    //         );
                    //
                    //       } : () {
                    //         showCustomToast("18 스테이지를 클리어하면 열립니다!", ToastType.small);
                    //       }
                    //     ),
                    //   ),
                    // ),
                    // buildRightMenuContainer(context: context),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

Widget buildRightMenuContainer({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  return Positioned(
    right: 0,
    bottom: MediaQuery.of(context).size.height * 0.4,
    child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                // SigninResult result =  await PlayGames.signIn();

                // print(result);
                await GamesServices.showAchievements();
              },
              child: Container(
                child: Icon(
                  Icons.military_tech,
                  size: gs.s1(),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                showSettingDialog(context: context);
              },
              child: Container(
                child: Icon(
                  Icons.settings,
                  size: gs.s2(),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        )),
  );
}
