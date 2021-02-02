import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {

  Color backgroundColor;
  Widget child;
  var onTap;


  CustomButton({this.backgroundColor, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)), color: backgroundColor),
          child: child
      ),
    );
  }
}
