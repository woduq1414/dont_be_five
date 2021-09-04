import 'dart:convert';
import 'dart:math';
import 'package:dont_be_five/common/ip.dart';
import 'package:dont_be_five/page/CustomLevelSelectPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/GameMode.dart';
import 'package:dont_be_five/data/LevelDataJson.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/page/GamePage.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';

import 'color.dart';

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

void moveToLevel(
    {int level, BuildContext context, bool isSkipTutorial = false, bool isCustomLevel, LevelData customLevelData}) async {
  GlobalStatus gs = context.read<GlobalStatus>();

  if (isCustomLevel == true) {
    // gs.currentGameMode = GameMode.CUSTOM_LEVEL_EDITING;
  } else {
    gs.currentGameMode = GameMode.ORIGINAL_LEVEL_PLAY;
  }
  // GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

  List<LevelData> levelDataList = gs.levelDataList;
  print(levelDataList);

  if (gs.isDebug) {
    Map<String, dynamic> mapJson = MapJsonClass.getMapJson();
    levelDataList = mapJson["levels"].map<LevelData>((x) => LevelData.fromJson(x)).toList();
  }

  LevelData _currentLevelData;

  gs.context = context;

  if (isCustomLevel != true) {
    try {
      _currentLevelData = levelDataList.firstWhere((el) => el.seq == level);
    } catch (e) {
      showCustomToast("곧 업데이트 됩니다! 감사합니다!", ToastType.small);
      return;
    }
  } else {
    _currentLevelData = customLevelData;
  }

  gs.deviceSize = MediaQuery.of(context).size;

  gs.levelData = _currentLevelData.clone();

  gs.initLevel();

  gs.tileCornerOffsetList = calcTileCornerOffsetList(levelData: _currentLevelData, context: context);

  print("asdf ${gs.tileCornerOffsetList.length}");

  gs.personDataList = makePersonDataList(levelData: _currentLevelData, context: context);

  for (int i = 0; i < _currentLevelData.mapHeight; i++) {
    for (int j = 0; j < _currentLevelData.mapWidth; j++) {
      if (Tiles.getTileType(tile: TileData(x: j, y: i), levelData: _currentLevelData) == Tiles.goal) {
        gs.goalTile = TileData(x: j, y: i);
        break;
      }
    }
  }

  Navigator.pushReplacement(
    context,
    FadeRoute(
        page: GamePage(
            level: level, isSkipTutorial: isSkipTutorial, isCustomMap: isCustomLevel, customLevelData: customLevelData)),
  );
}

List<dynamic> calcTileCornerOffsetList({LevelData levelData, BuildContext context, Offset translationOffset}) {
  if (translationOffset == null) {
    translationOffset = Offset(0, 0);
  }

  double deviceWidth;
  double deviceHeight;

  Offset leftTopCorner;
  Offset rightTopCorner;
  Offset leftBottomCorner;
  Offset rightBottomCorner;

  List<dynamic> _tileCornerOffsetList = [];

  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;

  // setState(() {
  //   _tileCornerOffsetList[0] = deviceWidth;
  // });
  double fullWidth = deviceWidth * 0.9;

  double pTheta = 75 * (pi / 180);
  // double pW = 300;
  // double pH = 250;
  double pRatio = 5 / 6; // 평행사면형 높이 / 밑변

  double pH = fullWidth / (1 / tan(pTheta) + 1 / pRatio);
  double pW = pH / pRatio;

  leftTopCorner = Offset(fullWidth - pW, deviceHeight / 2 - pH / 2);

  rightTopCorner = Offset(fullWidth, deviceHeight / 2 - pH / 2);
  leftBottomCorner = Offset(0, deviceHeight / 2 + pH / 2);
  rightBottomCorner = Offset(pW, deviceHeight / 2 + pH / 2);

  leftTopCorner = Offset(leftTopCorner.dx + translationOffset.dx, leftTopCorner.dy + translationOffset.dy);
  rightTopCorner = Offset(rightTopCorner.dx + translationOffset.dx, rightTopCorner.dy + translationOffset.dy);
  leftBottomCorner = Offset(leftBottomCorner.dx + translationOffset.dx, leftBottomCorner.dy + translationOffset.dy);
  rightBottomCorner = Offset(rightBottomCorner.dx + translationOffset.dx, rightBottomCorner.dy + translationOffset.dy);

  for (int i = 0; i < levelData.mapHeight + 1; i++) {
    _tileCornerOffsetList.add([]);
    for (int j = 0; j < levelData.mapWidth + 1; j++) {
      _tileCornerOffsetList[i].add(Offset(
          interDivision(start: leftTopCorner.dx, end: rightTopCorner.dx, m: j, n: levelData.mapWidth - j) -
              interDivision(start: leftBottomCorner.dx, end: leftTopCorner.dx, m: i, n: levelData.mapHeight - i) +
              (deviceWidth - fullWidth) / 2,
          interDivision(start: leftTopCorner.dy, end: leftBottomCorner.dy, m: i, n: levelData.mapHeight - i)));
    }
    ;
  }

  return _tileCornerOffsetList;
}

List<dynamic> makePersonDataList({LevelData levelData, BuildContext context}) {
  List<PersonData> personDataList = [];

  for (int i = 0; i < levelData.mapHeight; i++) {
    for (int j = 0; j < levelData.mapWidth; j++) {
      if (1 <= levelData.map[i][j] && levelData.map[i][j] <= 9) {
        for (int k = 0; k < levelData.map[i][j]; k++) {
          // personList.add(Person(x: j, y:i, idx:k, count: levelData.map[i][j],));
          personDataList.add(PersonData.fromJson({
            "x": j,
            "y": i,
            "idx": k,
            "count": levelData.map[i][j],
            "hash": getRandString(15),
            "isPlayer": false,
          }));
        }
      }
      if (101 <= levelData.map[i][j] && levelData.map[i][j] <= 109) {
        for (int k = 0; k < levelData.map[i][j] - 100; k++) {
          // personList.add(Person(x: j, y:i, idx:k, count: levelData.map[i][j],));
          personDataList.add(PersonData.fromJson({
            "x": j,
            "y": i,
            "idx": k,
            "count": levelData.map[i][j] - 100,
            "hash": getRandString(15),
            "isPlayer": true,
          }));
        }
      }
    }
  }

  return personDataList;
}

dynamic showPublishCustomLevelDialog({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  var yy = YYDialog();

  return yy.build(context)
    ..barrierDismissible = !gs.isHttpLoading
    ..width = gs.deviceSize.width * 0.9
    ..backgroundColor = Colors.white12.withOpacity(1)
    ..duration = Duration(milliseconds: 400)
    ..widget(WillPopScope(
      onWillPop: () async {
        if(gs.isHttpLoading){

        }else{
          yy.dismiss();
        }

        return false;
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // width: gs.deviceS,

            child: Container(
              // padding: EdgeInsets.symmetric(),
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("맵 게시", style: TextStyle(fontSize: gs.s3())),
                SizedBox(
                  height: 5,
                ),
                Builder(builder: (context) {
                  final myController = TextEditingController(
                      text:
                          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}");

                  String title = "";

                  bool _isPublic = true;

                  bool _isUploading = false;

                  return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '맵 이름',
                              ),
                              onChanged: (x) {},
                              controller: myController,
                            )
                          ],
                        ),
                        Row(

                          children: [
                            SizedBox(width: 8,),
                            Text("공개 여부", style: TextStyle(fontSize: gs.s5())),
                            Switch(
                              value: _isPublic,
                              onChanged: (value) {
                                state(() {
                                  _isPublic = value;
                                });
                              },
                            )
                          ],
                        ),

                        FutureBuilder(
                            future: getNickname(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                              if (snapshot.hasData == false) {
                                return Container();
                              }
                              //error가 발생하게 될 경우 반환하게 되는 부분
                              else if (snapshot.hasError) {
                                return Container();
                              }
                              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                              else {
                                return Text("제작자 : ${snapshot.data}", style: TextStyle(fontSize: gs.s5()));
                              }
                            }),
                        SizedBox(height: 5,),

                        Text("※ 비공개 시 맵 코드로만 검색할 수 있습니다.", style: TextStyle(fontSize: gs.s5())),
                        SizedBox(height: 5,),
                        Container(
                          child: CustomButton(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                    _isUploading == true ?  Material(
                      color: Colors.transparent,
                      child: Text("업로드 중...",
                          style: TextStyle(
                            fontSize: gs.s5(),
                          )),
                    ) :  Material(
                      color: Colors.transparent,
                      child: Text("업로드",
                          style: TextStyle(
                            fontSize: gs.s5(),
                          )),
                    ),
                              ],
                            ),
                            backgroundColor: primaryYellow,
                            onTap: _isUploading == true ? null :  () async {

                              if(myController.text.length < 1 && myController.text.length > 30){
                                showCustomToast("맵 이름을 1~30자로 입력해주세요.", ToastType.small);
                                return;
                              }

                              String appVersion = gs.appVersion;
                              String deviceId = await getDeviceId();
                              print(deviceId);

                              gs.isHttpLoading = true;
                              state(() {
                                _isUploading = true;
                              });

                              final res = await http.post(
                                Uri.parse("${currentHost}/custom-level/upload"),
                                body: jsonEncode({
                                  "device_id" : deviceId,
                                  "app_version" : appVersion,
                                  "title" : myController.text,
                                  "level_data" : gs.tempCustomLevelData.clone().toJson(),
                                  "is_public" : _isPublic,
                                  "nickname" : await getNickname()
                                }),
                                headers: {"Content-Type": "application/json"},
                              );
                              gs.isHttpLoading = false;

                              print(res.body);

                              if(res.statusCode == 200){
                                showCustomToast("업로드 성공!", ToastType.small);
                              }else{
                                showCustomToast("업로드 에러!", ToastType.small);
                              }

                              yy.dismiss();


                              gs.isEditMode = false;
                              gs.notify();
                              Navigator.popUntil(context, (route) => route.isFirst);

                              Navigator.push(
                                context,
                                FadeRoute(page: CustomLevelSelectPage()),
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
      ),
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

void publishCustomLevel({BuildContext context}) async {
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);


  if (gs.testedLevelData != null &&
      gs.tempCustomLevelData != null &&
      gs.tempCustomLevelData.toJson().toString() == gs.testedLevelData.toJson().toString()) {
    // showCustomToast("게시 가능(아직 안 만듦)", ToastType.small);
    showPublishCustomLevelDialog(context: context);


  } else {
    showCustomToast("현재 맵을 별 3개로 통과해야 게시할 수 있습니다.", ToastType.small);
  }
}

Future<String> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  var androidDeviceInfo = await deviceInfo.androidInfo;
  return androidDeviceInfo.androidId; // unique ID on Android
}

getNickname() async {
  var storage = FlutterSecureStorage();
  String nickname = await storage.read(key: "nickname");
  if(nickname == null){
    nickname = "익명";
  }
  return nickname;

}