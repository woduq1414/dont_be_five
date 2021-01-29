import 'dart:convert';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import 'GamePage.dart';




class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);


    return Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text("gg"),
            onPressed: (){
              print("SDF");
              Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => GamePage(level: 2,)));
            },
          )
        )
    );
  }
}
