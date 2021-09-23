import 'package:dont_be_five/common/color.dart';
import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  Widget child;
  bool isShapeShow;

  BackgroundScreen({this.child, this.isShapeShow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            image: isShapeShow == true ? DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("./assets/images/new_background.png"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
            ) : null),
        child: child);
  }
}
