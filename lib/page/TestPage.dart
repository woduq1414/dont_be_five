import 'dart:convert';
import 'dart:math';
import 'package:dont_be_five/common/firebase.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import 'GamePage.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {

    // AdManager.init();
    // AdManager.showBanner();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);
    gs.deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("sample map 1"),
                  onPressed: () async {
                    moveToLevel(level: 1, context: context);
                  },
                ),
                RaisedButton(
                  child: Text("sample map 2"),
                  onPressed: () async {
                    moveToLevel(level: 2, context: context);
                  },
                ),
                RaisedButton(
                  child: Text("sample map 3"),
                  onPressed: () async {
                    moveToLevel(level: 3, context: context);
                  },
                ),
                RaisedButton(
                  child: Text("level select"),
                  onPressed: () async {

                    Navigator.push(
                      context,
                      FadeRoute(page: LevelSelectPage()),
                    );
                  },
                )
              ],
            )));
  }



}

