import 'dart:ffi';
import 'dart:io';

import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/CustomLevelSelectPage.dart';
import 'package:dont_be_five/page/LevelSelectPage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/widget/MenuBox.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:games_services/games_services.dart';
import 'package:provider/provider.dart';

import 'StoryLevelSelectPage.dart';

class NewHomePage extends StatefulWidget {
  NewHomePage({Key key}) : super(key: key);

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    // var storage = FlutterSecureStorage();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

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
      child: Scaffold(
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
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
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
                                    child: Image.asset("./assets/images/new_user.png"),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: Text(
                                          gs.nickname,
                                          style: TextStyle(
                                            fontFamily: Font.nanumRegular,
                                            fontSize: gs.s5() * 0.8,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "레벨 1",
                                        style: TextStyle(
                                          fontFamily: Font.nanumRegular,
                                          fontSize: 10,
                                          color: Color(0xff555555),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () async{
                                  await GamesServices.showAchievements();
                                },
                                child: Icon(Icons.military_tech, color: primaryPurple, size: gs.s5() * 1.2,)
                            ),
                            SizedBox(width : 8),

                            GestureDetector(
                              onTap: () {
                                showSettingDialog(context: context);
                              },
                              child: Icon(Icons.settings, color: primaryPurple, size: gs.s5() * 1.2,)
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "메뉴",
                              style: TextStyle(
                                fontFamily: Font.nanumRegular,
                                fontWeight: FontWeight.w900,
                                fontSize: gs.s5(),
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          MenuBox(
                            title: "단계모드",
                            subtitle: "5인 이상 집합 금지 룰을 준수하여 플레이해요",
                            isHighlight: false,
                            badgeText: gs.getLastUnlockedLevel().toString(),
                            onTap: () {
                              // moveToLevel(level: 23 , context: context);
                              // return;

                              Navigator.pushReplacement(
                                context,
                                // FadeRoute(page: LevelSelectPage()),
                                FadeRoute(page: LevelSelectPage(page: 0)),
                              );
                            },
                          ),
                          SizedBox(height : 10),
                          MenuBox(
                            title: "스토리모드",
                            subtitle: "각 상황에 맞는 규칙을 준수하여 다채로운 플레이를 즐겨보세요",
                            badgeText: "20.12",
                            isHighlight: false,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                // FadeRoute(page: LevelSelectPage()),
                                FadeRoute(page: StoryLevelSelectPage()),
                              );
                            },
                          ),
                          SizedBox(height : 10),
                          MenuBox(
                              title: "메이커스센터",
                              subtitle: "맵을 직접 만들거나 다른 유저들이 만든 맵을 플레이해요",
                              isHighlight: false,
                              onTap: gs.isCustomMapAvailable
                                  ? () {
                                      // moveToLevel(level: 23 , context: context);
                                      // return;

                                      Navigator.pushReplacement(
                                        context,
                                        FadeRoute(page: CustomLevelSelectPage()),
                                      );
                                    }
                                  : () {
                                      showCustomToast("18 스테이지를 클리어하면 열립니다!", ToastType.small);
                                    }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
