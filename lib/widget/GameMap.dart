import 'dart:math';
import 'dart:ui' as ui;
import 'package:dont_be_five/common/func.dart';
import 'package:dont_be_five/common/paint.dart';
import 'package:dont_be_five/data/Direction.dart';
import 'package:dont_be_five/data/HighlightTile.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/data/MapInstance.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/SelectMode.dart';
import 'package:dont_be_five/data/SelectType.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/TestPage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:touchable/touchable.dart';
import 'package:confetti/confetti.dart';

import 'Goal.dart';
import 'Item.dart';
import 'Person.dart';
import 'Toast.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

double interDivision({double start, double end, var m, var n}) {
  return (start * n + end * m) / (m + n);
}

class GameMap extends StatefulWidget {
  LevelData levelData;

  GameMap({this.levelData});

  @override
  _GameMapState createState() => _GameMapState(levelData);
}

class _GameMapState extends State<GameMap> {
  bool _isGoalDialogShowing = false;
  AudioCache audioCache = AudioCache();

  LevelData levelData;
  double deviceWidth;
  double deviceHeight;

  Offset leftTopCorner;
  Offset rightTopCorner;
  Offset leftBottomCorner;
  Offset rightBottomCorner;

  _GameMapState(this.levelData);

  List<Widget> _cachedPersonBuilder = [];

  List<dynamic> _tileCornerOffsetList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
      gs.audioPlayer.pause();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);
    // gs.audioCache = audioCache;

    setState(() {
      levelData = gs.levelData;
      _tileCornerOffsetList = gs.tileCornerOffsetList;
    });
    if (gs.isEditMode && gs.isRenewPersonBuilder) {
      setState(() {
        _cachedPersonBuilder = personBuilder(context: context);
        gs.isRenewPersonBuilder = false;
      });
    }
    if (_cachedPersonBuilder.length == 0 && gs.isEditMode == false) {
      // print("hello;");
      _cachedPersonBuilder = personBuilder(context: context);
    }

    // print("rebuild");
    // print(_cachedPersonBuilder);

    if (gs.isGameCleared && _isGoalDialogShowing == false) {
      gs.isGameCleared = false;

      _isGoalDialogShowing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        gs.isGameCleared = true;

        showGoalDialog(context);
        gs.isGameCleared = false;
        print("SDDDDDDDDDDDDDDDDDDDDDDDDDDd");
        if (levelData.seq == 24) {
          if (gs.isRateDialogShowed == false) {
            gs.isRateDialogShowed = true;
            showCustomConfirmDialog(
                context: context,
                title: "게임이 어떠신가요?",
                content: "평가해주시면 다음 업데이트에 도움이 됩니다 :)",
                confirmButtonAction: () {
                  Navigator.of(context).pop();
                  LaunchReview.launch(
                    androidAppId: "com.aperture.dont_be_five",
                  );
                },
                cancelButtonAction: () {
                  Navigator.of(context).pop();
                },
                cancelButtonText: "나중에",
                confirmButtonText: "평가하기");
          }
        } else {}
      });
    }
    // print("sdf");
    // print(_cachedPersonBuilder);
    return Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(context: context),
              ),
            ),
            SizedBox.expand(
              child: CanvasTouchDetector(
                builder: (context) => CustomPaint(
                  painter: MapPainter(levelData: levelData, tileCornerOffsetList: _tileCornerOffsetList, context: context),
                ),
              ),
            ),
            CustomPaint(
              painter: HighlightTilePainter(tileCornerOffsetList: _tileCornerOffsetList, context: context),
            ),
            Goal(),
            ... gs.isEditMode ? personBuilder(context: context) :  _cachedPersonBuilder,
            itemContainerBuilder(context: context)
          ],
        ));
  }
}

Widget itemContainerBuilder({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context);
  if (gs.isEditMode) {
    return Container();
  }
  if (gs.levelData.items.length == 0) {
    return Container();
  }

  return Positioned.fill(
    bottom: 80,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          // decoration:
          //     BoxDecoration(color: Color.fromRGBO(50, 50, 50, 0.7), borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: gs.levelData.items.keys.map<Widget>((item) {
                  return Item(itemName: item);
                }).toList()),
          )),
    ),
  );
}

Widget itemBuilder({BuildContext context, String itemName}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context);

  ItemData item;

  switch (itemName) {
    case "isolate":
      item = ItemData.isolate;
      break;
    case "release":
      item = ItemData.release;
      break;
    case "vaccine":
      item = ItemData.vaccine;
      break;
    case "diagonal":
      item = ItemData.diagonal;
      break;
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: GestureDetector(
      onTap: () {
        gs.selectItem(item);
        print("SD");
      },
      child: Container(
          decoration:
              BoxDecoration(color: Color.fromRGBO(240, 240, 240, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Image.asset(
                    item.imagePath,
                    width: 35,
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Material(
                      color: Colors.transparent,
                      child: Text(
                        gs.levelData.items[itemName].toString(),
                        style: TextStyle(fontSize: gs.s6()),
                      )),
                ),
              )
            ],
          )),
    ),
  );
}

class MapPainter extends CustomPainter {
  LevelData levelData;
  List<dynamic> tileCornerOffsetList;
  final BuildContext context;
  bool isSample;

  @override
  void paint(Canvas canvas, Size size) {
    Paint frontWallPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2, size.height / 1),
        [Colors.yellow, Colors.orangeAccent],
      );

    Paint sideWallPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2, size.height / 1),
        [Colors.amber, Colors.orange],
      );

    Paint wallBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(0, 0, 0, 0.2)
      ..strokeWidth = 1;

    Paint tileBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(0, 0, 0, 0.35)
      ..strokeWidth = 1;

    Paint tileFillPaint = Paint()
      ..shader = ui.Gradient.linear(
        tileCornerOffsetList[levelData.mapHeight][0],
        tileCornerOffsetList[0][levelData.mapWidth],
        [Colors.white, Color.fromRGBO(250, 250, 250, 1)],
      );

    ////////////////////////////////////////////////////////

    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    var myCanvas = TouchyCanvas(context, canvas);

    var borderCornerList =
        new List<List>.generate(levelData.mapHeight + 1, (i) => List<bool>.generate(levelData.mapWidth + 1, (j) => false));

    for (int i = 0; i < levelData.mapHeight; i++) {
      int startIdx;
      for (int j = 0; j < levelData.mapWidth; j++) {
        if ((levelData.map[i][j] != -1) && (i == levelData.mapHeight - 1 || levelData.map[i + 1][j] == -1)) {
          if (j == levelData.mapWidth - 1) {
            // canvas.drawLine(tileCornerOffsetList[i+1][j+1], Offset(tileCornerOffsetList[i+1][j+1].dx, 9999), borderPaint);
            borderCornerList[i + 1][j + 1] = true;
          }
          if (startIdx == null) {
            // canvas.drawLine(tileCornerOffsetList[i+1][j], Offset(tileCornerOffsetList[i+1][j].dx, 9999), borderPaint);
            startIdx = j;
            borderCornerList[i + 1][j] = true;
          } else {}
        } else {
          if (startIdx != null) {
            startIdx = null;
            // canvas.drawLine(tileCornerOffsetList[i+1][j], Offset(tileCornerOffsetList[i+1][j].dx, 9999), borderPaint);
            borderCornerList[i + 1][j] = true;
          }
        }
      }
    }

    for (int j = 0; j < levelData.mapWidth; j++) {
      int startIdx;
      for (int i = 0; i < levelData.mapHeight; i++) {
        if ((levelData.map[i][j] != -1) && (j == levelData.mapWidth - 1 || levelData.map[i][j + 1] == -1)) {
          // Path path = new Path();
          // List<Offset> points = [
          //   tileCornerOffsetList[i+1][j+1],
          //   tileCornerOffsetList[i][j+1],
          //   Offset(tileCornerOffsetList[i][j+1].dx, 9999),
          //   Offset(tileCornerOffsetList[i+1][j+1].dx, 9999),
          // ];
          // path.addPolygon(points, true);
          // canvas.drawPath(path, paint3);

          if (i == levelData.mapHeight - 1) {
            // canvas.drawLine(tileCornerOffsetList[i+1][j+1], Offset(tileCornerOffsetList[i+1][j+1].dx, 9999), borderPaint);
            borderCornerList[i + 1][j + 1] = true;
          }
          if (startIdx == null) {
            // canvas.drawLine(tileCornerOffsetList[i][j+1], Offset(tileCornerOffsetList[i][j+1].dx, 9999), borderPaint);
            startIdx = j;
            borderCornerList[i][j + 1] = true;
          } else {}
        } else {
          if (startIdx != null) {
            startIdx = null;
            // canvas.drawLine(tileCornerOffsetList[i][j+1], Offset(tileCornerOffsetList[i][j+1].dx, 9999), borderPaint);
            borderCornerList[i][j + 1] = true;
          }
        }
      }
    }

    for (int j = 0; j < levelData.mapWidth + 1; j++) {
      if (borderCornerList[0][j] == true) {
        canvas.drawLine(tileCornerOffsetList[0][j], Offset(tileCornerOffsetList[0][j].dx, 9999), wallBorderPaint);
      }
    }
    for (int i = 0; i < levelData.mapHeight; i++) {
      for (int j = 0; j < levelData.mapWidth; j++) {
        Path path = new Path();

        if (i < levelData.mapHeight && j < levelData.mapWidth && levelData.map[i][j] != -1) {
          if ((i == levelData.mapHeight - 1 || levelData.map[i + 1][j] == -1)) {
            List<Offset> points = [
              tileCornerOffsetList[i + 1][j],
              tileCornerOffsetList[i + 1][j + 1],
              Offset(tileCornerOffsetList[i + 1][j + 1].dx, 9999),
              Offset(tileCornerOffsetList[i + 1][j].dx, 9999),
            ];
            path.addPolygon(points, true);
            canvas.drawPath(path, frontWallPaint);
          }
          if (j == levelData.mapWidth - 1 || levelData.map[i][j + 1] == -1) {
            Path path = new Path();
            List<Offset> points = [
              tileCornerOffsetList[i + 1][j + 1],
              tileCornerOffsetList[i][j + 1],
              Offset(tileCornerOffsetList[i][j + 1].dx, 9999),
              Offset(tileCornerOffsetList[i + 1][j + 1].dx, 9999),
            ];
            path.addPolygon(points, true);
            canvas.drawPath(path, sideWallPaint);
          }
        }

        if (borderCornerList[i + 1][j] == true) {
          canvas.drawLine(tileCornerOffsetList[i + 1][j], Offset(tileCornerOffsetList[i + 1][j].dx, 9999), wallBorderPaint);
        }
      }

      if (borderCornerList[i + 1][levelData.mapWidth] == true) {
        canvas.drawLine(tileCornerOffsetList[i + 1][levelData.mapWidth],
            Offset(tileCornerOffsetList[i + 1][levelData.mapWidth].dx, 9999), wallBorderPaint);
      }
      // for (int j = 0; )

    }

    void onTileTapDownAction(int i, int j) {

      print(gs.isEditMode);

      if (isSample) {
        return;
      }

      // gs.movePerson(x:j, y:i, d : Direction(-1,0));
      if (gs.isEditMode == false) {

        if (gs.selectMode == SelectMode.normal) {
          gs.selectTile(tile: TileData(x: j, y: i), selectType: SelectType.personSelect);
        } else if (gs.selectMode == SelectMode.move) {
          // print("!@#!@#");
          gs.selectTile(tile: TileData(x: j, y: i), selectType: SelectType.personMove);
        } else if (gs.selectMode == SelectMode.itemTargetSelect) {
          // print("!@#!@#");
          gs.selectTile(tile: TileData(x: j, y: i), selectType: SelectType.itemTargetSelect);
        }
      } else {
        LevelData tempLevelData = gs.levelData;
        TileData targetTile = TileData(x: j, y: i);

        bool f = false;
        for (TileData t in gs.highlightTileMap[HighlightTile.selectable]) {
          if (t.x == j && t.y == i) {
            f = true;
            break;
          }
        }
        if (f == false) {
          return;
        }

        switch (gs.selectedMapInstance) {
          case MapInstance.blankTile:
            if (tempLevelData.map[i][j] == 999999) {
              gs.goalTile = null;
            }

            tempLevelData.map[i][j] = -1;
            tempLevelData.isolated[i][j] = 0;
            gs.isolatedTileList.removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
            gs.highlightTileMap[HighlightTile.isolated]
                .removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);

            tempLevelData.confined[i][j] = 0;
            gs.confinedTileList.removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
            gs.highlightTileMap[HighlightTile.confined]
                .removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);

            gs.personDataList.removeWhere((p) => (p.x == targetTile.x && p.y == targetTile.y));

            gs.levelData = tempLevelData;

            break;
          case MapInstance.blockTile:
            tempLevelData.map[i][j] = 0;

            if (tempLevelData.isolated[i][j] == 1) {
              tempLevelData.isolated[i][j] = 0;
              gs.isolatedTileList.removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
              gs.highlightTileMap[HighlightTile.isolated]
                  .removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
            }

            if (tempLevelData.confined[i][j] == 1) {

              tempLevelData.confined[i][j] = 0;
              gs.confinedTileList.removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
              gs.highlightTileMap[HighlightTile.confined]
                  .removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
            }


            gs.levelData = tempLevelData;
            break;
          case MapInstance.isolatedTile:
            if (tempLevelData.isolated[i][j] == 0) {
              tempLevelData.isolated[i][j] = 1;
              gs.isolatedTileList.add(targetTile);
              gs.highlightTileMap[HighlightTile.isolated].add(targetTile);
            } else {
              tempLevelData.isolated[i][j] = 0;
              gs.isolatedTileList.removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
              gs.highlightTileMap[HighlightTile.isolated]
                  .removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
            }

            gs.levelData = tempLevelData;
            break;
          case MapInstance.confinedTile:
            if (tempLevelData.confined[i][j] == 0) {
              tempLevelData.confined[i][j] = 1;
              gs.confinedTileList.add(targetTile);
              gs.highlightTileMap[HighlightTile.confined].add(targetTile);
            } else {
              tempLevelData.confined[i][j] = 0;
              gs.confinedTileList.removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
              gs.highlightTileMap[HighlightTile.confined]
                  .removeWhere((element) => element.x == targetTile.x && element.y == targetTile.y);
            }
            gs.levelData = tempLevelData;
            break;

          case MapInstance.eraserObject:
            if (1 <= tempLevelData.map[i][j] && tempLevelData.map[i][j] <= 4) {
              gs.personDataList.removeWhere((p) => (p.x == targetTile.x &&
                  p.y == targetTile.y &&
                  p.idx == tempLevelData.map[targetTile.y][targetTile.x] - 1));

              tempLevelData.map[i][j] -= 1;
            } else if (101 <= tempLevelData.map[i][j] && tempLevelData.map[i][j] <= 104) {
              gs.personDataList.removeWhere((p) => (p.x == targetTile.x &&
                  p.y == targetTile.y &&
                  p.idx == tempLevelData.map[targetTile.y][targetTile.x] - 100 - 1));

              tempLevelData.map[i][j] -= 1;

              if (tempLevelData.map[i][j] == 100) {
                tempLevelData.map[i][j] = 0;
              }
            } else if (tempLevelData.map[i][j] == 999999) {
              tempLevelData.map[i][j] = 0;
              gs.goalTile = null;
            }

            gs.levelData = tempLevelData;
            gs.isFiveAll();

            gs.isRenewPersonBuilder = true;
            // gs.notify();
            break;

          case MapInstance.playerObject:
            int cnt = 0;
            for (int i = 0; i < tempLevelData.mapHeight; i++) {
              for (int j = 0; j < tempLevelData.mapWidth; j++) {
                if (101 <= tempLevelData.map[i][j] && tempLevelData.map[i][j] <= 104) {
                  cnt += tempLevelData.map[i][j] - 100;
                }
              }
            }
            if (cnt >= 4) {
              showCustomToast("플레이어는 최대 4개까지 놓을 수 있습니다.", ToastType.small);
              break;
            }

            if (tempLevelData.map[i][j] == 0) {
              tempLevelData.map[i][j] = 101;
            } else {
              tempLevelData.map[i][j] += 1;
            }
            gs.levelData = tempLevelData;

            gs.isRenewPersonBuilder = true;

            gs.personDataList.add(PersonData.fromJson({
              "x": j,
              "y": i,
              "idx": levelData.map[i][j] - 100 - 1,
              "count": levelData.map[i][j] - 100,
              "hash": getRandString(15),
              "isPlayer": true,
            }));

            print(gs.personDataList);

            gs.notify();

            gs.isFiveAll();

            break;
          case MapInstance.personObject:
            if (tempLevelData.map[i][j] >= 4) {
              break;
            }

            if (tempLevelData.map[i][j] == 0) {
              tempLevelData.map[i][j] = 1;
            } else {
              tempLevelData.map[i][j] += 1;
            }
            gs.levelData = tempLevelData;

            gs.isRenewPersonBuilder = true;

            gs.personDataList.add(PersonData.fromJson({
              "x": j,
              "y": i,
              "idx": levelData.map[i][j] - 1,
              "count": levelData.map[i][j],
              "hash": getRandString(15),
              "isPlayer": false,
            }));

            print(gs.personDataList);

            gs.notify();

            gs.isFiveAll();
            break;
          case MapInstance.goalObject:
            int cnt = 0;
            for (int i = 0; i < tempLevelData.mapHeight; i++) {
              for (int j = 0; j < tempLevelData.mapWidth; j++) {
                if (tempLevelData.map[i][j] == 999999) {
                  cnt += 1;
                }
              }
            }
            if (cnt >= 1) {
              showCustomToast("목적지는 최대 1개까지 놓을 수 있습니다.", ToastType.small);
              break;
            }

            tempLevelData.map[i][j] = 999999;
            gs.levelData = tempLevelData;
            gs.goalTile = targetTile;
            break;
        }

        gs.updateEditAvailableTile();
      }
    }

    for (int i = 0; i < levelData.mapHeight; i++) {
      for (int j = 0; j < levelData.mapWidth; j++) {
        Path path = new Path();
        List<Offset> points = [
          tileCornerOffsetList[i][j],
          tileCornerOffsetList[i][j + 1],
          tileCornerOffsetList[i + 1][j + 1],
          tileCornerOffsetList[i + 1][j],
        ];
        path.addPolygon(points, true);

        if (levelData.map[i][j] == -1) {
          if (gs.isEditMode) {
            Paint transparentPaint = Paint()
              ..style = PaintingStyle.fill
              ..color = Colors.transparent;

            Paint greyBorderPaint = Paint()
              ..style = PaintingStyle.stroke
              ..color = Colors.grey;

            myCanvas.drawPath(
              path,
              gs.selectedMapInstance == MapInstance.blockTile ? greyBorderPaint : transparentPaint,
              onTapDown: (x) {
                onTileTapDownAction(i, j);
              },
            );
          }

          continue;
        }

        myCanvas.drawPath(path, tileFillPaint, onTapDown: (x) {
          onTileTapDownAction(i, j);
        });
        canvas.drawPath(
          path,
          tileBorderPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  MapPainter({this.levelData, this.tileCornerOffsetList, this.context, this.isSample = false});
}

List<Widget> personBuilder({BuildContext context, List<PersonData> pdl, List<dynamic> tcol}) {
  print("what?");
  GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
  List<dynamic> personDataList;
  if (pdl != null) {
    personDataList = pdl;
  } else {
    personDataList = context.select((GlobalStatus gs) => gs.personDataList);
    personDataList = personDataList.map((x) {
      return x.clone();
    }).toList();
  }
  // List<dynamic> personDataList = gs.personDataList;
  // = gs.personDataList;

  if (personDataList == null) {
    showCustomToast("asd", ToastType.normal);
    print("asdddddddddddddddddddddddddddddddddd");
    return [Container(), Container()];
  }
  // print(personDataList.length);
  // print("--------");
  // for(var a in personDataList){
  //
  //   print("${a.hash} ${a.x} ${a.y}");
  // }
  // print("--------??");

  bool isEditMode = gs.isEditMode;
  // bool isHomePage = gs.isHomePage;
  return personDataList.map((x) {
    // print("${x.clone().hash} hash : ");

    if (isEditMode) {
      return personWidgetBuilder(context: context, hash: x.hash);
    } else {
      return Person(
        hash: x.hash, personDataList: pdl,
      );
    }
  }).toList();
}

class HighlightTilePainter extends CustomPainter {
  final BuildContext context;
  List<dynamic> tileCornerOffsetList;

  HighlightTilePainter({this.context, this.tileCornerOffsetList});

  @override
  void paint(Canvas canvas, Size size) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

    for (String key in gs.availableTileList.keys) {
      for (TileData t in gs.availableTileList[key]) {
        int i = t.y;
        int j = t.x;

        Paint paint = HighlightTile.getPaint(
            highlightType: key, targetTile: t, selectedTile: gs.selectedTile, tileCornerOffsetList: gs.tileCornerOffsetList);

        Path path = new Path();
        List<Offset> points = [
          tileCornerOffsetList[i][j],
          tileCornerOffsetList[i][j + 1],
          tileCornerOffsetList[i + 1][j + 1],
          tileCornerOffsetList[i + 1][j],
        ];
        path.addPolygon(points, true);

        canvas.drawPath(
          path,
          paint,
        );

        if (key == HighlightTile.isolated) {
          double distance = 20;
          double stroke = 3;
          Offset position = path.getBounds().center;
          double widthf = path.getBounds().width / 2.0;
          double heightf = path.getBounds().height / 2.0;

          Path _path = Path();
          _path.moveTo(position.dx, position.dy);
          for (int i = 0; i < widthf / distance * 2; i++) {
            _path.relativeMoveTo(-distance * i, 0);
            _path.relativeMoveTo(widthf, -heightf);
            _path.relativeLineTo(-widthf * 2, heightf * 2);
            _path.moveTo(position.dx, position.dy);

            _path.relativeMoveTo(distance * i, 0);
            _path.relativeMoveTo(widthf, -heightf);
            _path.relativeLineTo(-widthf * 2, heightf * 2);
            _path.moveTo(position.dx, position.dy);
          }
          canvas.save();
          canvas.clipPath(path);

          canvas.drawPath(
              _path..fillType = PathFillType.evenOdd,
              Paint()
                ..color = Colors.redAccent.withOpacity(0.7)
                ..style = PaintingStyle.stroke
                ..strokeWidth = stroke);
          canvas.restore();
        }
      }
    }

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
