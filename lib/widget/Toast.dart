import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showCustomToast(String message, ToastType type){
  if(type == ToastType.normal){
    showToastWidget(
        Container(
            margin: EdgeInsets.only(top:45, left: 5, right: 5),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.all(Radius.circular(15)),
              color: Color.fromRGBO(30, 30, 30, 0.5),
            ),
            child : Text(message, style: TextStyle(fontSize: 24, color: Colors.white,), textAlign: TextAlign.center,)
        )
    );
  }else if(type== ToastType.small){
    showToastWidget(
        Container(
            margin: EdgeInsets.only(top:45, left: 5, right: 5),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.all(Radius.circular(15)),
              color: Color.fromRGBO(30, 30, 30, 0.5),
            ),
            child : Text(message, style: TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center,)
        )
    );
  }


}