import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/firebase.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:games_services/games_services.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

import 'GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin  {

  LevelData _levelData = LevelData.fromJson({
    "seq": 99,
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


  DateTime currentBackPressTime;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();

    super.dispose();
  }

  test() async{
    // SigninResult result =  await PlayGames.signIn();
  }


  void initState() {
    // TODO: implement initState



    AdManager.init();
    AdManager.showBanner();



    // GamesServices.signIn();
    // test();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 8.0,).animate(new CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInCirc
    ))
      ..addListener(() {
        setState(() {});
      });


    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
        _tileCornerOffsetList = calcTileCornerOffsetList(levelData: _levelData, context: context);
        gs.tileCornerOffsetList = _tileCornerOffsetList;

        _personDataList = makePersonDataList(levelData: _levelData, context: context);


        // _levelData =

        gs.levelData = _levelData;
        gs.personDataList = _personDataList;
        gs.deviceSize = MediaQuery.of(context).size;
        print(_levelData);

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    gs.deviceSize = MediaQuery.of(context).size;





    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 1)) {
          currentBackPressTime = now;
          return Future.value(false);
        }

        exit(1);

        return Future.value(true);
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




                _tileCornerOffsetList != null?
                SizedBox.expand(
                  child: CanvasTouchDetector(
                    builder: (context) => CustomPaint(
                      painter:
                          MapPainter(levelData: _levelData, tileCornerOffsetList: _tileCornerOffsetList, context: context),
                    ),
                  ),
                ) : Container(),
                ... _tileCornerOffsetList != null? personBuilder(context: context) : [Container()],
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03 + _animation.value,
                      ),
                      Image.asset(ImagePath.titleLogo, color: Colors.white,),

                    ],
                  ),
                ),

                Positioned.fill(
                  bottom: 130 ,
                  left: 15,
                  right: 15,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.play_arrow, size: gs.s2()),
                          SizedBox(
                            width: 5,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Text("시작하기",
                                style: TextStyle(
                                  fontSize: gs.s4(),
                                )),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.white70.withOpacity(0.9),
                      onTap: () {

                        // moveToLevel(level: 23 , context: context);
                        // return;

                        Navigator.pushReplacement(
                          context,
                          FadeRoute(page: LevelSelectPage()),
                        );
                      },
                    ),
                  ),
                ),
                buildRightMenuContainer(context: context),
              ],
            )),
      ),
    );
  }
}

Widget buildRightMenuContainer({BuildContext context}){
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
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () async{
              // SigninResult result =  await PlayGames.signIn();

              // print(result);
              await GamesServices.showAchievements();

            },
            child: Container(
              child: Icon(Icons.military_tech, size: gs.s1(), color: Colors.white,),
            ),
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
              showSettingDialog(context :context);


            },
            child: Container(
              child: Icon(Icons.settings, size: gs.s2(), color: Colors.white,),
            ),
          ),
          SizedBox(height: 5,),
        ],
      )
    ),
  );
}