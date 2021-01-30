import 'dart:ui';
import 'package:flutter/material.dart';
class HighlightTile {


  static const String selected = "selected";
  static const String moveable = "moveable";
  static const String five = "five";


  static Paint getPaint({String highlightType}){
    Paint paint;

    if(highlightType == HighlightTile.selected){
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Color.fromRGBO(230, 230, 230, 0.5);
    }else if(highlightType == HighlightTile.moveable){
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Colors.blueAccent.withOpacity(0.5);
    }else if(highlightType == HighlightTile.five){
      paint = Paint();
      paint.style = PaintingStyle.fill;
      paint.color = Colors.red.withOpacity(0.8);
    }

    return paint;
  }

}