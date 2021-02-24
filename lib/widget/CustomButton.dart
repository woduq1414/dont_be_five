import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {

  Color backgroundColor;
  Widget child;
  var onTap;
  BorderRadius borderRadius;

  CustomButton({this.backgroundColor, this.borderRadius, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {

    if(borderRadius == null){
      borderRadius = BorderRadius.all(Radius.circular(10));
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: borderRadius, color: backgroundColor),
          child: child
      ),
    );
  }
}
