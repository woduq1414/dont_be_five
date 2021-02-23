import 'dart:convert';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/MapInstance.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipedetector/swipedetector.dart';

import 'HomePage.dart';

class MapEditPage extends StatefulWidget {
  MapEditPage();

  @override
  _MapEditPageState createState() => _MapEditPageState();
}

class _MapEditPageState extends State<MapEditPage> {
  LevelData _currentLevelData;

  final double _initFabHeight = 27.0;
  double _fabHeight;
  double _panelHeightOpen = 190;
  double _panelHeightClosed = 25.0;
  PanelController _pc = new PanelController();

  _MapEditPageState();

  List<dynamic> tabData = [
    {
      "tabName": "타일",
    },
    {
      "tabName": "오브젝트",
    },
    {
      "tabName": "아이템",
    }
  ];

  int _selectedTabIndex;

  MapInstance _selectedInstance;

  @override
  void initState() {
    // TODO: implement initState
    _selectedTabIndex = 0;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

      gs.isEditMode = true;
      gs.selectedMapInstance = null;
      _currentLevelData = LevelData.fromJson({
        "seq": 9999999,
        "mapWidth": 5,
        "mapHeight": 4,
        "map": [
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ],
        "confined": [
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ],
        "isolated": [
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ],
        "pStarCondition": ["clear", "move 21 & clear", "move 18 & clear"]
      });
      gs.goalTile = null;
      gs.levelData = _currentLevelData;
      gs.initLevel();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);

    setState(() {
      if (levelData == null) {
        // List<LevelData> levelDataList =context.select((GlobalStatus gs) => gs.levelDataList);
        GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
      }

      _panelHeightOpen = MediaQuery.of(context).size.height * 0.35;
    });

    Widget buildTabMenu(int tabIndex) {
      bool isSelected = tabIndex == _selectedTabIndex;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = tabIndex;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          margin: EdgeInsets.only(bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Container(
              margin: EdgeInsets.only(right: 2),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Color.fromRGBO(220, 220, 220, 1) : Colors.white,
                // borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                tabData[tabIndex]["tabName"],
                style: TextStyle(fontSize: gs.s4() * 0.9),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    Widget buildTabContent(int tabIndex) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context);
      Widget contentWidget = Container();
      if (tabIndex == 0) {
        contentWidget = Container(
          // height: 1000,
          child: GridView.count(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 1,
              children: [MapInstance.blankTile, MapInstance.blockTile, MapInstance.isolatedTile, MapInstance.confinedTile]
                  .map((x) {
                bool isSelectedInstance = gs.selectedMapInstance == x;

                return GestureDetector(
                  onTap: () {
                    if (isSelectedInstance) {
                      gs.selectedMapInstance = null;
                    } else {
                      gs.selectedMapInstance = x;
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(7),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                      color: isSelectedInstance ? Color.fromRGBO(210, 210, 210, 1) : Colors.white,
                    ),
                    child: Text(x.name),
                  ),
                );
              }).toList()),
        );
      } else if (tabIndex == 1) {
        contentWidget = Container(
            // height: 1000,
            child: GridView.count(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 1,
                children: [MapInstance.eraserObject, MapInstance.playerObject, MapInstance.personObject, MapInstance.goalObject]
                    .map((x) {
                  bool isSelectedInstance = gs.selectedMapInstance == x;

                  return GestureDetector(
                    onTap: () {
                      if (isSelectedInstance) {
                        gs.selectedMapInstance = null;
                      } else {
                        gs.selectedMapInstance = x;
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(7),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                        color: isSelectedInstance ? Color.fromRGBO(210, 210, 210, 1) : Colors.white,
                      ),
                      child: Text(x.name),
                    ),
                  );
                }).toList()));
      } else if (tabIndex == 2) {
      } else {}

      return contentWidget;
    }

    Widget _buildUnderBox() {
      return Material(
        color: Colors.transparent,
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(8),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 35,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: tabData.map((x) {
                        return buildTabMenu(tabData.indexOf(x));
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        // color: Colors.blue,
                        child: buildTabContent(_selectedTabIndex)),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();

        return true;
      },
      child: Stack(
        children: [
          Container(
            child: GameMap(
              levelData: _currentLevelData,
            ),
          ),
          Builder(
            builder: (context) {
              return SlidingUpPanel(
                defaultPanelState: PanelState.OPEN,
                minHeight: _panelHeightClosed,
                maxHeight: _panelHeightOpen,
                controller: _pc,
                color: Colors.white.withOpacity(0.9),
                panel: _buildUnderBox(),
                onPanelSlide: (double pos) => setState(() {
                  _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
                }),
              );
            },
          ),
          utilButtonContainerBuilder2(context: context),
        ],
      ),
    );
  }
}

Widget utilButtonContainerBuilder2({BuildContext context}) {
  GlobalStatus gs = Provider.of<GlobalStatus>(context);
  return Positioned(
    // right: 20,
    top: 10 + MediaQuery.of(context).padding.top,
    child: Container(
        width: gs.deviceSize.width,
        padding: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        FadeRoute(page: MapEditPage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(Icons.replay),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
  );
}
