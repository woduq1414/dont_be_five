import 'dart:ffi';

import 'package:dont_be_five/common/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuBox extends StatelessWidget {
  String title;
  String subtitle;

  bool isHighlight;
  double backgroundOpacity = 0.85;

  MenuBox(this.title, this.subtitle, [this.isHighlight = false]);

  @override
  Widget build(BuildContext context) {
    if (isHighlight) {
      backgroundOpacity = 1;
    }

    print(isHighlight);

    return InkWell(
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: Color(0xffffff).withOpacity(backgroundOpacity),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: "NanumSquare",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: "NanumSquare",
                            fontSize: 10,
                            color: Color(0xff555555),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                "./assets/images/new_settings.png",
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewHomePage extends StatefulWidget {
  NewHomePage({Key key}) : super(key: key);

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              newBackgroundGradient1,
              newBackgroundGradient2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("./assets/images/new_background.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: Image.asset(
                "./assets/images/new_logo.png",
                height: 50,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                      color: Color(0xffffff).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                      "./assets/images/new_user.png"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "jjy37777",
                                        style: TextStyle(
                                          fontFamily: "NanumSquare",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "레벨 123",
                                      style: TextStyle(
                                        fontFamily: "NanumSquare",
                                        fontSize: 10,
                                        color: Color(0xff555555),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            "./assets/images/new_settings.png",
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 60, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "이어하기",
                            style: TextStyle(
                              fontFamily: "NanumSquare",
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        MenuBox("제목", "부제목", false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
