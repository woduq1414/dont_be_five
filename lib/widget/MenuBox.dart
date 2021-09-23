import 'package:dont_be_five/common/Font.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MenuBox extends StatelessWidget {
  String title;
  String subtitle;

  bool isHighlight;
  double backgroundOpacity = 0.85;

  String badgeText;

  var onTap;

  MenuBox({this.title, this.subtitle, this.isHighlight = false, this.onTap, this.badgeText});

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = context.read<GlobalStatus>();
    if (isHighlight) {
      backgroundOpacity = 1;
    }

    print(isHighlight);

    return Material(
      color: Color(0xffffff).withOpacity(backgroundOpacity),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 75,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontFamily: Font.nanumRegular,
                                      fontSize: gs.s5() * 0.97,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  badgeText != null
                                      ? Container(
                                          margin : EdgeInsets.only(left : 4),
                                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryPurple,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Text(badgeText,
                                              style: TextStyle(
                                                  fontSize: gs.s6() * 0.8, color: Colors.white, fontFamily: Font.nanumRegular)))
                                      : Container()
                                ],
                              )),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontFamily: Font.nanumRegular,
                              fontSize: 10,
                              color: Color(0xff555555),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: gs.s2(),
                  color: Colors.black45,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
