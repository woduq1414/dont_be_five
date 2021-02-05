import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
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

  int page = 0;


  LevelSelectPage({this.page});

  @override
  _LevelSelectPageState createState() => _LevelSelectPageState(page);
}

class _LevelSelectPageState extends State<LevelSelectPage> {
  int _page;
  _LevelSelectPageState(int page){

    if(page == null){
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


    setState(() {



    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    _levelProcessList = gs.getLevelProcessList();

    print(_page);
    print(_page);
    print(_page);
    print(_page);    print(_page);    print(_page);    print(_page);





    return WillPopScope(
      onWillPop: () async{
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
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                        color: Colors.transparent,
                        child: Text(
                          "LEVEL SELECT",
                          style: TextStyle(fontSize: gs.s1(), color: Colors.white),
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
                        GestureDetector(
                          onTap: () {
                            buttonCarouselController.previousPage(
                                duration: Duration(milliseconds: 200), curve: Curves.easeOut);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
                              child: Icon(
                                Icons.chevron_left,
                                size: gs.s1(),
                              )),
                        ),
                        // SizedBox(width: gs.s4(),),
                        Expanded(
                            child: CarouselSlider.builder(
                          itemCount: 15,
                          carouselController: buttonCarouselController,
                          itemBuilder: (BuildContext context, int itemIndex, int _) =>
                              Center(child: levelContainerBuilder(context: context, page: itemIndex)),
                          options: CarouselOptions(
                            height: gs.deviceSize.height * 0.57,
                            autoPlay: false,
                            reverse: false,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            aspectRatio: 1,
                            // height: ,
                            initialPage: _page,
                          ),
                        )),

                        // SizedBox(width: gs.s4(),),
                        GestureDetector(
                          onTap: () {
                            buttonCarouselController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeOut);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
                              child: Icon(
                                Icons.chevron_right,
                                size: gs.s1(),
                              )),
                        ),

                        SizedBox(
                          width: 5,
                        ),
                      ],
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

  Widget levelContainerBuilder({BuildContext context, int page}) {
    int pageSize = 12;
    return Container(
      // height: 350,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: List.generate(pageSize, (index) {
          return levelBuilder(
              context: context, level: pageSize * page + index + 1, levelStatus: _levelProcessList[pageSize * page + index]);
        }),
      ),
    );
  }

  Widget levelBuilder({int level, int levelStatus, BuildContext context}) {
    GlobalStatus gs = context.watch<GlobalStatus>();
    List<bool> havingStar = [];
    havingStar.add(levelStatus % 2 == 1);
    havingStar.add(levelStatus ~/ 2 % 2 == 1);
    havingStar.add(levelStatus ~/ 4 % 2 == 1);

    return GestureDetector(
      onTap: levelStatus != -1
          ? () {
              moveToLevel(level: level, context: context);
            }
          : null,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 0),
          decoration: levelStatus != -1
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white.withOpacity(1),
                  boxShadow: [
                    BoxShadow(
                      color: levelStatus == 7 ? Colors.yellowAccent.withOpacity(0.5) : Colors.white12.withOpacity(0.5),
                      spreadRadius:levelStatus == 7 ? 3 : 2,
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
                    style: TextStyle(fontSize: 25, color: levelStatus != -1 ? Colors.black : Colors.black.withOpacity(0.5)),
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
  }
}
