import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'TileData.dart';
import 'Tiles.dart';

class HighlightTile {

  static Offset getCenterOffset(Offset a, Offset b){
    return Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
  }

  static const String selected = "selected";
  static const String moveable = "moveable";
  static const String five = "five";
  static const String selectable = "selectable";
  static const String isolated = "isolated";

  static Paint getPaint(

      {String highlightType, TileData targetTile, TileData selectedTile, List<dynamic> tileCornerOffsetList}) {
    Paint paint;

    if (highlightType == HighlightTile.selected) {
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Color.fromRGBO(230, 230, 230, 0.5);
    } else if (highlightType == HighlightTile.moveable) {
      paint = Paint()
        ..shader = ui.Gradient.radial(
          getCenterOffset(Tiles.getTileCenterOffset(tile: selectedTile, tileCornerOffsetList: tileCornerOffsetList),  Tiles.getTileCenterOffset(tile: targetTile, tileCornerOffsetList: tileCornerOffsetList)),
          25,

          [
            Colors.white.withOpacity(1),
            Colors.greenAccent.withOpacity(0.8),
          ],
        );
      // paint.style = PaintingStyle.fill;
      // paint.color = Colors.blueAccent.withOpacity(0.5);
    } else if (highlightType == HighlightTile.five) {
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Colors.red.withOpacity(0.8);
    }else if (highlightType == HighlightTile.selectable) {
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Colors.lightBlueAccent.withOpacity(0.5);
    }else if (highlightType == HighlightTile.isolated) {
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Colors.white.withOpacity(0.5);

    }

    return paint;
  }
}
