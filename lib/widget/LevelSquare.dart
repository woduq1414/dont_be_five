import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'Dialog.dart';

Widget levelBuilder({int realLevel, int level, int levelStatus, BuildContext context}) {
  if(realLevel == null){
    realLevel = level;
  }

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

        moveToLevel(level: realLevel, context: context, displayLevel : level);
      }
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 0),
            decoration: levelStatus != -1
                ? BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white.withOpacity(1),
              boxShadow: [
                BoxShadow(
                  color: levelStatus == 7 ? primaryPurple.withOpacity(0.5) : Colors.white12.withOpacity(0.5),
                  spreadRadius: levelStatus == 7 ? 3 : 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            )
                : BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.7)),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                        color: Colors.transparent,
                        child: Text(
                          level >= 100 ? level.toString().padLeft(3, "0") : level.toString().padLeft(2, "0"),
                          style: TextStyle(
                              fontSize: 25,
                              color: levelStatus != -1 ? primaryPurple : primaryPurple.withOpacity(0.5),
                              fontFamily: Font.nanumExtraBold,
                              fontWeight: FontWeight.bold),
                        )),
                    levelStatus != -1
                        ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: havingStar.map((e) {
                            return e == true
                                ? Flexible(flex: 3, child: Icon(Icons.star, color: primaryPurple, size: gs.s3()))
                                : Flexible(
                                flex: 3,
                                child: Icon(Icons.star, color: primaryPurple.withOpacity(0.25), size: gs.s3()));
                          }).toList()),
                    )
                        : Container(
                      child: Center(child : Icon(Icons.lock, color: primaryPurple.withOpacity(0.5), size: gs.s3())),
                    ),
                  ],
                ))),
      ),
    );
  });
}