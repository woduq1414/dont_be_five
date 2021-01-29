import 'dart:math';

import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class GameMap extends StatefulWidget {
  LevelData levelData;

  GameMap({this.levelData});

  @override
  _GameMapState createState() => _GameMapState(levelData);
}

class _GameMapState extends State<GameMap> {
  LevelData levelData;
  double deviceWidth;
  double deviceHeight;

  Offset leftTopCorner;
  Offset rightTopCorner;
  Offset leftBottomCorner;
  Offset rightBottomCorner;

  _GameMapState(this.levelData);

  List<dynamic> _tileCornerOffsetList = [];

  @override
  void initState() {
    super.initState();

    print("leveldata : ");
    print(levelData);
    new Future.delayed(Duration.zero, () {
      deviceWidth = MediaQuery.of(context).size.width;
      deviceHeight = MediaQuery.of(context).size.height;
      print(deviceWidth);

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

      double interDivision({double start, double end, var m, var n}) {
        return (start * n + end * m) / (m + n);
      }

      setState(() {
        print("hello${(deviceWidth - fullWidth) / 2}");
        leftTopCorner = Offset(fullWidth - pW, deviceHeight / 2 - pH / 2);

        rightTopCorner = Offset(fullWidth, deviceHeight / 2 - pH / 2);
        leftBottomCorner = Offset(0, deviceHeight / 2 + pH / 2);
        rightBottomCorner = Offset(pW, deviceHeight / 2 + pH / 2);
        print(leftBottomCorner);
        print(rightBottomCorner);
        print(leftTopCorner);
        print(rightTopCorner);
        for (int i = 0; i < levelData.mapHeight + 1; i++) {
          _tileCornerOffsetList.add([]);
          for (int j = 0; j < levelData.mapWidth + 1; j++) {
            _tileCornerOffsetList[i].add(Offset(
                interDivision(start: leftTopCorner.dx, end: rightTopCorner.dx, m: j, n: levelData.mapWidth - j) -
                    interDivision(start: leftBottomCorner.dx, end: leftTopCorner.dx, m: i, n: levelData.mapHeight - i) +
                    (deviceWidth - fullWidth) / 2,
                interDivision(start: leftTopCorner.dy, end: leftBottomCorner.dy, m: i, n: levelData.mapHeight - i)));
          }
          print(_tileCornerOffsetList[i]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CanvasTouchDetector(
          builder: (context) => CustomPaint(
            painter: TilePainter(levelData: levelData, tileCornerOffsetList: _tileCornerOffsetList, context: context),
          ),
        ));
  }
}

class TilePainter extends CustomPainter {
  LevelData levelData;
  List<dynamic> tileCornerOffsetList;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    // var paint1 = Paint()
    //   ..color = Colors.black
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 5;
    // //a rectangle
    // canvas.drawRect(Offset(100, 100) & Size(200, 100), paint1);

    // data = [Offset(0, 0), Offset(100, 0), Offset(100, 50), Offset(0, 50)];

    // var points = data;
    // print(points);
    // path.addPolygon(points, true);
    Paint borderPaint = Paint();
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = Color.fromRGBO(0, 0, 0, 1);
    borderPaint.strokeWidth = 2;

    Paint paint2 = Paint();
    paint2.style = PaintingStyle.fill;
    paint2.color = Color.fromRGBO(255, 255, 0, 1.0);

    Paint paint3 = Paint();
    paint3.style = PaintingStyle.fill;
    paint3.color = Color.fromRGBO(252, 223, 3, 1.0);

    var borderCornerList =
        new List<List>.generate(levelData.mapHeight + 1, (i) => List<bool>.generate(levelData.mapWidth + 1, (j) => false));
    print(borderCornerList);

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
        canvas.drawLine(tileCornerOffsetList[0][j], Offset(tileCornerOffsetList[0][j].dx, 9999), borderPaint);
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
            canvas.drawPath(path, paint2);
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
            canvas.drawPath(path, paint3);
          }
        }

        if (borderCornerList[i + 1][j] == true) {
          canvas.drawLine(tileCornerOffsetList[i + 1][j], Offset(tileCornerOffsetList[i + 1][j].dx, 9999), borderPaint);
        }
      }

      if (borderCornerList[i + 1][levelData.mapWidth] == true) {
        canvas.drawLine(tileCornerOffsetList[i + 1][levelData.mapWidth],
            Offset(tileCornerOffsetList[i + 1][levelData.mapWidth].dx, 9999), borderPaint);
      }
      // for (int j = 0; )

    }

    for (int i = 0; i < levelData.mapHeight; i++) {
      for (int j = 0; j < levelData.mapWidth; j++) {
        if (levelData.map[i][j] == -1) {
          continue;
        }

        Paint borderPaint = Paint();
        borderPaint.style = PaintingStyle.stroke;
        borderPaint.color = Color.fromRGBO(0, 0, 0, 1.0);
        borderPaint.strokeWidth = 1.5;

        Paint paint = Paint();
        paint.style = PaintingStyle.fill;
        paint.color = Color.fromRGBO(255, 255, 255, 1.0);
        Path path = new Path();
        List<Offset> points = [
          tileCornerOffsetList[i][j],
          tileCornerOffsetList[i][j + 1],
          tileCornerOffsetList[i + 1][j + 1],
          tileCornerOffsetList[i + 1][j],
        ];
        path.addPolygon(points, true);

        myCanvas.drawPath(path, paint, onTapDown: (x) {
          print("${i}, ${j}");
        });
        canvas.drawPath(
          path,
          borderPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  TilePainter({this.levelData, this.tileCornerOffsetList, this.context});
}
