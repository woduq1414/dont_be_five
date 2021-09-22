import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/firebase.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/ip.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/GameMode.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/page/TestPage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Loading.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'GamePage.dart';
import 'package:http/http.dart' as http;

import 'MapEditPage.dart';

class CustomLevelSelectPage extends StatefulWidget {
  int page = 0;

  Map<String, dynamic> searchData;

  bool myLevel = false;

  CustomLevelSelectPage({this.page, this.searchData, this.myLevel});

  @override
  _CustomLevelSelectPageState createState() => _CustomLevelSelectPageState(page, searchData, myLevel);
}

class _CustomLevelSelectPageState extends State<CustomLevelSelectPage> {
  int _page;
  int _maxPage;
  bool _isPageLoading = false;

  Map<String, dynamic> _searchData;

  bool _myLevel = false;

  _CustomLevelSelectPageState(int page, Map<String, dynamic> searchData, bool myLevel) {
    if (page == null) {
      // page = 0;

      page = 0;
    }
    _page = page;

    _searchData = searchData;

    if (myLevel != null) {
      _myLevel = myLevel;
    }
  }

  CarouselController buttonCarouselController = CarouselController();

  List<dynamic> _customLevelJsonList = [];

  getCustomLevelList() async {
    if (_page < 0) {
      showCustomToast("첫 페이지입니다!", ToastType.small);
      _page = 0;
      return;
    }

    if (_maxPage != null) {
      if (_page > _maxPage) {
        showCustomToast("마지막 페이지입니다!", ToastType.small);
        _page = _maxPage;
        return;
      }
    }

    setState(() {
      _isPageLoading = true;
    });

    Map<String, dynamic> postBody = {};

    if (_searchData != null) {
      postBody["query"] = _searchData["query"];
      postBody["type"] = _searchData["type"];
    }
    postBody["page"] = _page;

    postBody["device_id"] = await getDeviceId();

    if (_myLevel == true) {
      print("fsdfffffff");
      postBody["type"] = "my";
    }

    final res = await http.post(
      Uri.parse("${currentHost}/custom-level/list"),
      body: jsonEncode(postBody),
      headers: {"Content-Type": "application/json"},
    );
    setState(() {
      _isPageLoading = false;
    });
    var resBody = jsonDecode(res.body);
    print(_customLevelJsonList.length);

    if (resBody["data"].length == 0) {
      setState(() {
        _maxPage = _page - 1;
      });
      showCustomToast("검색 결과가 더 없습니다!", ToastType.small);
      return;
    }

    setState(() {
      _customLevelJsonList = resBody["data"];
    });
  }

  void nicknameSetCheck({BuildContext context}) async {
    var storage = FlutterSecureStorage();

    String nickname = await storage.read(key: "nickname");
    if (nickname == null) {
      showSetNicknameDialog(context: context);
    }
  }

  @override
  void initState() {
    AdManager.hideBanner();

    // TODO: implement initState

    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nicknameSetCheck(context: context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
      gs.audioPlayer.resume();
    });
    getCustomLevelList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          FadeRoute(page: HomePage()),
        );

        // if(Navigator.)

        // Navigator.pop(context, "goHome");

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
                      height: 30,
                    ),
                    Material(
                        color: Colors.transparent,
                        child: Text(
                          "CUSTOM LEVEL",
                          style: TextStyle(fontSize: gs.s1(), color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.search, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("검색",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.8),
                          onTap: () {
                            showCustomLevelSearchDialog(context: context);
                          },
                        ),
                        CustomButton(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("내 작품",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.8),
                          onTap: () {
                            Navigator.push(
                              context,
                              FadeRoute(page: CustomLevelSelectPage(page: 0, myLevel: true)),
                            );
                          },
                        ),
                        CustomButton(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.construction, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("맵 에디터",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.8),
                          onTap: () {
                            gs.testedLevelData = null;
                            gs.isEditMode = true;
                            gs.currentGameMode = GameMode.CUSTOM_LEVEL_EDITING;
                            gs.notify();
                            print(gs.isEditMode);
                            Navigator.pushReplacement(
                              context,
                              FadeRoute(page: MapEditPage()),
                            );
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: _isPageLoading == true
                          ? Center(child: CustomLoading())
                          : Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _page = _page - 1;
                                    });
                                    await getCustomLevelList();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white.withOpacity(0.8)),
                                      child: Icon(
                                        Icons.chevron_left,
                                        size: gs.s1(),
                                      )),
                                ),
                                // SizedBox(width: gs.s4(),),
                                Expanded(
                                    child: ListView(
                                        children: _customLevelJsonList.map((x) {
                                  return buildCustomLevelTile(context: context, customLevelJson: x);
                                }).toList())),

                                // SizedBox(width: gs.s4(),),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _page = _page + 1;
                                    });
                                    await getCustomLevelList();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white.withOpacity(0.8)),
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
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pop(context, "goHome");

                        Navigator.pushReplacement(
                          context,
                          FadeRoute(
                              page: CustomLevelSelectPage(
                            page: 0,
                          )),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.8)),
                          child: Icon(
                            Icons.replay,
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

  Widget buildCustomLevelTile({BuildContext context, dynamic customLevelJson}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    return Material(
      color: Colors.transparent,
      child: Container(
          height: 80,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.only(top: 2, left: 5, bottom: 2),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customLevelJson["title"],
                      style: TextStyle(fontSize: gs.s4()),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          customLevelJson["nickname"],
                          style: TextStyle(fontSize: gs.s5() * 0.8),
                          textAlign: TextAlign.left,
                        ),
                        customLevelJson["isMine"] == true
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.person,
                                    size: gs.s5(),
                                    color: Colors.orangeAccent,
                                  )
                                ],
                              )
                            : Container()
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showCustomLevelPlayDialog(context: context, customLevelJson: customLevelJson);
                },
                child: Container(
                  height: 80,
                  color: Colors.white.withOpacity(0.2),
                  width: 55,
                  child: Center(
                      child: Icon(
                    Icons.arrow_right_sharp,
                    size: gs.s1() * 1.1,
                    color: Colors.white,
                  )),
                ),
              )
            ],
          )),
    );
  }

  dynamic showCustomLevelPlayDialog({BuildContext context, dynamic customLevelJson}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    var yy = YYDialog();

    return yy.build(context)
      ..barrierDismissible = true
      ..width = gs.deviceSize.width * 0.9
      ..backgroundColor = Colors.white12.withOpacity(1)
      ..duration = Duration(milliseconds: 400)
      ..widget(Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // width: gs.deviceS,

            child: Container(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("커스텀 맵", style: TextStyle(fontSize: gs.s3())),
                Divider(),
                Builder(builder: (context) {
                  return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.yellowAccent,
                                    width: 80,
                                    child: Text("맵 이름 : ",
                                        style: TextStyle(
                                          fontSize: gs.s4(),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    customLevelJson["title"],
                                    style: TextStyle(
                                      fontSize: gs.s5(),
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.yellowAccent,
                                    width: 80,
                                    child: Text("제작자 : ",
                                        style: TextStyle(
                                          fontSize: gs.s4(),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                        customLevelJson["nickname"],
                                        style: TextStyle(
                                          fontSize: gs.s5(),
                                        ),
                                        textAlign: TextAlign.center,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.yellowAccent,
                                    width: 80,
                                    child: Text("맵 코드 : ",
                                        style: TextStyle(
                                          fontSize: gs.s4(),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    customLevelJson["levelId"],
                                    style: TextStyle(
                                      fontSize: gs.s5(),
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            if (customLevelJson["isMine"] == true)
                              Flexible(
                                child: Container(
                                  child: CustomButton(
                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.delete, size: gs.s3()),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Text("삭제",
                                              style: TextStyle(
                                                fontSize: gs.s5(),
                                              )),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.withOpacity(0.5),
                                    onTap: () {
                                      showCustomConfirmDialog(
                                          context: context,
                                          title: "정말로 맵을 삭제하시겠어요?",
                                          content: "다시 되돌릴 수 없습니다.",
                                          confirmButtonAction: () async {
                                            final res = await http.post(
                                              Uri.parse("${currentHost}/custom-level/delete"),
                                              body: jsonEncode({
                                                "device_id": await getDeviceId(),
                                                "level_id": customLevelJson["levelId"]
                                              }),
                                              headers: {"Content-Type": "application/json"},
                                            );

                                            Navigator.of(context).pop();
                                            yy.dismiss();

                                            Navigator.pushReplacement(
                                              context,
                                              FadeRoute(
                                                  page: CustomLevelSelectPage(
                                                page: 0,
                                              )),
                                            );
                                          },
                                          cancelButtonAction: () {
                                            Navigator.of(context).pop();
                                          },
                                          cancelButtonText: "취소",
                                          confirmButtonText: "삭제하기");
                                    },
                                  ),
                                ),
                              )
                            else
                              Container(),
                            Flexible(
                              child: Container(
                                child: CustomButton(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.arrow_right_alt, size: gs.s3()),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Text("플레이",
                                            style: TextStyle(
                                              fontSize: gs.s5(),
                                            )),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: primaryYellow,
                                  onTap: () {
                                    gs.currentGameMode = GameMode.CUSTOM_LEVEL_PLAY;

                                    LevelData customLevelData = LevelData.fromJson(customLevelJson["levelData"]);
                                    gs.playingCustomLevelData = customLevelData;
                                    print("width is");
                                    print(customLevelData.mapWidth);
                                    yy.dismiss();

                                    moveToLevel(context: context, isCustomLevel: true, customLevelData: customLevelData);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
                }),
              ],
            )),
          )
        ],
      ))
      ..animatedFunc = (child, animation) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(
              0.0,
              Tween<double>(begin: -50.0, end: 0)
                  .animate(
                    CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                  )
                  .value,
            )
            ..scale(
              Tween<double>(begin: 0, end: 1.0)
                  .animate(
                    CurvedAnimation(curve: Curves.easeOut, parent: animation),
                  )
                  .value,
            ),
          child: child,
        );
      }
      ..show();
  }

  dynamic showCustomLevelSearchDialog({BuildContext context, dynamic customLevelJson}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    var yy = YYDialog();

    return yy.build(context)
      ..barrierDismissible = true
      ..width = gs.deviceSize.width * 0.9
      ..backgroundColor = Colors.white12.withOpacity(1)
      ..duration = Duration(milliseconds: 400)
      ..widget(Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // width: gs.deviceS,

            child: Container(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("검색", style: TextStyle(fontSize: gs.s3())),
                Divider(),
                Builder(builder: (context) {
                  final myController = TextEditingController();

                  String _searchType = "맵 이름";

                  return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  DropdownButton<String>(
                                    value: _searchType,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    // elevation: 16,
                                    // style: TextStyle(color: Colors.deepPurple),
                                    // underline: Container(
                                    //   height: 2,
                                    //   color: Colors.deepPurpleAccent,
                                    // ),
                                    onChanged: (String newValue) {
                                      state(() {
                                        _searchType = newValue;
                                      });
                                    },
                                    items: <String>['맵 이름', '맵 코드'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '검색어',
                                          ),
                                          onChanged: (x) {},
                                          controller: myController,
                                          style: TextStyle(fontSize: gs.s5(), height: 1, color: Colors.black)))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: CustomButton(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.search, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("검색",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                            backgroundColor: primaryYellow,
                            onTap: () {
                              yy.dismiss();
                              Navigator.pushReplacement(
                                context,
                                FadeRoute(
                                    page: CustomLevelSelectPage(
                                        page: 0, searchData: {"type": _searchType, "query": myController.text})),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  });
                }),
              ],
            )),
          )
        ],
      ))
      ..animatedFunc = (child, animation) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(
              0.0,
              Tween<double>(begin: -50.0, end: 0)
                  .animate(
                    CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                  )
                  .value,
            )
            ..scale(
              Tween<double>(begin: 0, end: 1.0)
                  .animate(
                    CurvedAnimation(curve: Curves.easeOut, parent: animation),
                  )
                  .value,
            ),
          child: child,
        );
      }
      ..show();
  }
}
