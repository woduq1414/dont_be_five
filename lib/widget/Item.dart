import 'package:audioplayers/audioplayers.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item extends StatefulWidget {
  String itemName;

  Item({this.itemName});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with TickerProviderStateMixin {
  String itemName;
  ItemData item;

  AnimationController _animationController;
  Animation _animation;

  bool _isSelected;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 8.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();

    itemName = widget.itemName;
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
      case "diagonal":
        item = ItemData.diagonal;
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context);

    setState(() {
      _isSelected = gs.selectedItem == item;
    });

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          if (_isSelected) {
            gs.selectItem(null);
          } else {
            gs.selectItem(item);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: gs.s1() * 1.8,
                height: gs.s1() * 1.8,
                decoration: BoxDecoration(
                    color: _isSelected ? Color.fromRGBO(245, 245, 245, 1) : Color.fromRGBO(255, 255, 255, 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: _isSelected
                        ? [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.45),
                                blurRadius: _animation.value,
                                spreadRadius: _animation.value)
                          ]
                        : []),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left:6, top:6, right:6, bottom : 6),
                          child: Image.asset(
                            item.imagePath,

                            // width: 35,
                          )),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        item.caption,
                        style: TextStyle(color: _isSelected ? primaryPurpleDark : Colors.black12.withOpacity(0.6), fontSize: gs.s5() * 0.82, ),
                      ),
                    ),
                    SizedBox(height: 4,)
                  ],
                )),
            SizedBox(height : 3),
            Container(
              alignment: Alignment.center,
              width: gs.s1() * 1.8,
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                  color: _isSelected ? Color.fromRGBO(245, 245, 245, 1) : Color.fromRGBO(255, 255, 255, 0.7),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  boxShadow: _isSelected
                      ? [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.45),
                              blurRadius: _animation.value,
                              spreadRadius: _animation.value)
                        ]
                      : []),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  gs.levelData.items[itemName].toString(),
                  style: TextStyle(color: _isSelected ? primaryPurpleDark : Colors.black12.withOpacity(0.6), fontSize: gs.s5() * 0.72),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
