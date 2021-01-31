import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;


class BackgroundPainter extends CustomPainter {
  final BuildContext context;

  BackgroundPainter({this.context});

  @override
  void paint(Canvas canvas, Size size) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

    Paint backgroundPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [
          Colors.purpleAccent,
          Colors.deepPurpleAccent,
        ],
      );

    Path path = new Path();
    List<Offset> points = [
      Offset(0, 0),
      Offset(MediaQuery.of(context).size.width, 0),
      Offset(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      Offset(0, MediaQuery.of(context).size.height),
    ];
    path.addPolygon(points, true);

    canvas.drawPath(
      path,
      backgroundPaint,
    );
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}