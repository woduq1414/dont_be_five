import 'dart:convert';
import 'dart:math';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import 'GamePage.dart';

class LevelSelectPage extends StatefulWidget {
  @override
  _LevelSelectPageState createState() => _LevelSelectPageState();
}

class _LevelSelectPageState extends State<LevelSelectPage> {
  int _chapter;

  List<bool> _isClearedList = List.generate(30, (index) {
    return false;
  });

  @override
  void initState() {
    // TODO: implement initState
    _chapter = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    return SafeArea(
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
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Material(
                      color: Colors.transparent,
                      child: Text(
                        "LEVEL SELECT(작동 안함)",
                        style: TextStyle(fontSize: gs.s1()),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
                          child: Icon(
                            Icons.chevron_left,
                            size: gs.s1(),
                          )),
                      // SizedBox(width: gs.s4(),),
                      Expanded(child: levelContainerBuilder(context: context)),
                      // SizedBox(width: gs.s4(),),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
                          child: Icon(
                            Icons.chevron_right,
                            size: gs.s1(),
                          )),

                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
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
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: List.generate(12, (index) {
          return levelBuilder(context: context, level: index + 1, isCleared: _isClearedList[index]);
        }),
      ),
    );
  }

  Widget levelBuilder({int level, bool isCleared, BuildContext context}) {
    GlobalStatus gs = context.watch<GlobalStatus>();
    return Container(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 0),
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
                    level.toString(),
                    style: TextStyle(fontSize: 25),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(flex: 2, child: Icon(Icons.star_border, size: gs.s3())),
                  Flexible(flex: 2, child: Icon(Icons.star_border, size: gs.s3())),
                  Flexible(flex: 2, child: Icon(Icons.star_border, size: gs.s3()))
                ],
              )
            ],
          ))),
    );
  }
}
