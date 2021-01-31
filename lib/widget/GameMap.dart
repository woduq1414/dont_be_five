import 'dart:math';
import 'dart:ui' as ui;
import 'package:dont_be_five/common/paint.dart';
import 'package:dont_be_five/data/Direction.dart';
import 'package:dont_be_five/data/HighlightTile.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/SelectMode.dart';
import 'package:dont_be_five/data/SelectType.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/HomePage.dart';
import 'package:dont_be_five/painter/BackgroundPainter.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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

  LevelData levelData;
  double deviceWidth;
  double deviceHeight;

  Offset leftTopCorner;
  Offset rightTopCorner;
  Offset leftBottomCorner;
  Offset rightBottomCorner;

  _GameMapState(this.levelData);

  List<Widget> _cachedPersonBuilder;

  List<dynamic> _tileCornerOffsetList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    setState(() {
      levelData = gs.levelData;
      _tileCornerOffsetList = gs.tileCornerOffsetList;
    });

    if (_cachedPersonBuilder == null) {
      _cachedPersonBuilder = personBuilder(context: context);
    }

    if(gs.isGameEnd && _isGoalDialogShowing == false){
      _isGoalDialogShowing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showGoalDialog(context);
      });

    }



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
            ..._cachedPersonBuilder,
            utilButtonContainerBuilder(context: context),
            itemContainerBuilder(context: context)
          ],
        ));
  }
}

Widget utilButtonContainerBuilder({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context);
  return Positioned(
    right: 20,
    top: 30,
    child: Container(
        decoration:
            BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.8), borderRadius: BorderRadius.all(Radius.circular(10))),
        child: GestureDetector(
          onTap: () {
            // gs.printAllPersonData();
            // showCustomToast("sdjflkjsdklfjklsdf", ToastType.normal);


            // YYDialogDemo(context);

            Navigator.of(context).pop();
            moveToLevel(level: gs.levelData.seq, context: context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(150, 150, 150, 0.5), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Icon(Icons.replay),
          ),
        )),
  );
}

Widget itemContainerBuilder({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context);
  return Positioned.fill(
    bottom: 80,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          decoration:
              BoxDecoration(color: Color.fromRGBO(50, 50, 50, 0.7), borderRadius: BorderRadius.all(Radius.circular(10))),
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
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: GestureDetector(
      onTap: () {
        gs.selectItem(item);
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

    for (int i = 0; i < levelData.mapHeight; i++) {
      for (int j = 0; j < levelData.mapWidth; j++) {
        if (levelData.map[i][j] == -1) {
          continue;
        }

        Path path = new Path();
        List<Offset> points = [
          tileCornerOffsetList[i][j],
          tileCornerOffsetList[i][j + 1],
          tileCornerOffsetList[i + 1][j + 1],
          tileCornerOffsetList[i + 1][j],
        ];
        path.addPolygon(points, true);

        myCanvas.drawPath(path, tileFillPaint, onTapDown: (x) {

          // gs.movePerson(x:j, y:i, d : Direction(-1,0));
          if (gs.selectMode == SelectMode.normal) {
            gs.selectTile(tile: TileData(x: j, y: i), selectType: SelectType.personSelect);
          } else if (gs.selectMode == SelectMode.move) {
            // print("!@#!@#");
            gs.selectTile(tile: TileData(x: j, y: i), selectType: SelectType.personMove);
          } else if (gs.selectMode == SelectMode.itemTargetSelect) {
            // print("!@#!@#");
            gs.selectTile(tile: TileData(x: j, y: i), selectType: SelectType.itemTargetSelect);
          }
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

  MapPainter({this.levelData, this.tileCornerOffsetList, this.context});
}

List<Widget> personBuilder({BuildContext context}) {
  List<PersonData> personDataList = context.select((GlobalStatus gs) => gs.personDataList);
  // = gs.personDataList;

  return personDataList.map((x) {
    return Person(
      hash: x.hash,
    );
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


