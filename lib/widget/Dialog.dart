import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/page/HomePage.dart';
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
    ..width = 300

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
                    SizedBox(height: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(Icons.star_border, size: 40),
                          Flexible(
                            child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  "클리어",
                                  style: TextStyle(fontSize: 16),
                                )),
                          )
                        ],),
                        Row(children: <Widget>[
                          Icon(Icons.star_border, size: 40),
                          Flexible(
                            child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  "155 이동 안에 클리어",
                                  style: TextStyle(fontSize: 16),
                                )),
                          )
                        ],),
                        Row(children: <Widget>[
                          Icon(Icons.star_border, size: 40),
                          Flexible(
                            child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  "100 이동 안에 클리어",
                                  style: TextStyle(fontSize: 16),
                                )),
                          )
                        ],)

                      ],
                    ),
                    SizedBox(height: 15,),

                    GestureDetector(
                      onTap : (){
                        Navigator.push(
                          context,
                          FadeRoute(page: HomePage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 85),
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey.withOpacity(0.8)),
                        child:  Icon(Icons.arrow_forward, size: gs.s3()),
                      ),
                    )
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