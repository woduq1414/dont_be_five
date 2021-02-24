import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dont_be_five/common/color.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/common/route.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/page/RouterPage.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/data/LevelData.dart';

import 'package:dont_be_five/data/GameMode.dart';

import 'package:dont_be_five/data/MapInstance.dart';
import 'package:dont_be_five/widget/CustomButton.dart';
import 'package:dont_be_five/widget/GameMap.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/data/global.dart';
import 'package:dont_be_five/provider/globalProvider.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:flutter/material.dart';
import 'package:dont_be_five/common/func.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipedetector/swipedetector.dart';

import 'HomePage.dart';

class MapEditPage extends StatefulWidget {
  LevelData tempLevelData;

  MapEditPage({this.tempLevelData});

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
    },
    {
      "tabName": "별 조건",
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

      gs.isCustomLevelTestCompleted = false;

      if (widget.tempLevelData == null) {
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
          "pStarCondition": ["clear", "move 5 & clear", "move 8 & clear"]
        });
        // _currentLevelData = LevelData.fromJson({
        //   "seq": 9999999,
        //   "mapWidth": 5,
        //   "mapHeight": 4,
        //   "map": [
        //     [0, 0, 101, 0, 999999],
        //     [0, -1, 1, 0, 0],
        //     [0, 0, 0, 2, 1],
        //     [0, 0, 0, 0, 0],
        //   ],
        //   "confined": [
        //     [0, 0, 0, 0, 0],
        //     [0, 0, 0, 0, 0],
        //     [0, 0, 0, 0, 0],
        //     [0, 0, 0, 0, 0],
        //   ],
        //   "isolated": [
        //     [0, 0, 0, 0, 0],
        //     [0, 0, 0, 0, 0],
        //     [0, 0, 0, 0, 0],
        //     [0, 0, 0, 0, 0],
        //   ],
        //   "pStarCondition": ["clear", "move 5 & clear", "move 8 & clear"]
        // });
      } else {
        _currentLevelData = widget.tempLevelData;
      }

      gs.goalTile = null;
      gs.levelData = _currentLevelData;
      gs.initLevel();
      gs.tileCornerOffsetList = calcTileCornerOffsetList(
          levelData: _currentLevelData, context: context, translationOffset: Offset(0, -gs.deviceSize.height * 0.08));

      gs.personDataList = makePersonDataList(context: context, levelData: _currentLevelData);
      gs.isRenewPersonBuilder = true;

      for (int i = 0; i < _currentLevelData.mapHeight; i++) {
        for (int j = 0; j < _currentLevelData.mapWidth; j++) {
          if (_currentLevelData.map[i][j] == 999999) {
            print("muya");
            gs.goalTile = TileData(x: j, y: i);
          }
        }
      }
      print(gs.goalTile);

      print(gs.personDataList);
      gs.notify();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    // gs.isEditMode = true;
    // gs.notify();
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

    dynamic showEditStarConditionDialog({BuildContext context, int pConditionIndex}) {
      GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
      var yy = YYDialog();

      return yy.build(context)
        ..barrierDismissible = true
        ..width = gs.deviceSize.width * 0.9
        ..backgroundColor = Colors.white12.withOpacity(1)
        ..duration = Duration(milliseconds: 400)
        ..widget(Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              // width: gs.deviceS,

              child: Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("별 조건 수정", style: TextStyle(fontSize: gs.s4())),
                  Builder(builder: (context) {
                    String originPCondition = _currentLevelData.pStarCondition[pConditionIndex];

                    bool _isMoveCountLimit = false;
                    int _moveCountLimitNum = 10;

                    bool _isItemCountLimit = false;
                    int _itemCountLimitNum = 1;
                    ItemData _itemCountLimitItem = ItemData.isolate;

                    for (String token in originPCondition.split("&")) {
                      token = token.trim();
                      if (token.split(" ")[0] == "move") {
                        _isMoveCountLimit = true;
                        _moveCountLimitNum = int.parse(token.split(" ")[1]);
                      } else if (token.split(" ")[0] == "no") {
                        _isItemCountLimit = true;
                        String targetItemName = token.split(" ")[1];
                        _itemCountLimitItem =
                            ItemData.getItemDataList().firstWhere((element) => element.name == targetItemName);
                        _itemCountLimitNum = 0;
                      } else if (token.split(" ")[0] == "limit") {
                        _isItemCountLimit = true;
                        String targetItemName = token.split(" ")[1];
                        _itemCountLimitItem =
                            ItemData.getItemDataList().firstWhere((element) => element.name == targetItemName);
                        _itemCountLimitNum = int.parse(token.split(" ")[2]);
                      }
                    }

                    String pCondition = "clear";

                    return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                      state(() {
                        pCondition = "";
                        if (_isMoveCountLimit == true) {
                          pCondition = "move ${_moveCountLimitNum} & ";
                        }
                        if (_isItemCountLimit == true) {
                          if (_itemCountLimitNum == 0) {
                            pCondition = pCondition + "no ${_itemCountLimitItem.name} & ";
                          } else {
                            pCondition = pCondition + "limit ${_itemCountLimitItem.name} ${_itemCountLimitNum} & ";
                          }
                        }
                        pCondition += "clear";
                      });

                      return Column(children: [
                        ExpansionTile(
                          initiallyExpanded: _isMoveCountLimit,
                          title: Text(
                            "${_isMoveCountLimit ? "(o)" : "(X)"} 이동 횟수 제한",
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          onExpansionChanged: (x) {
                            state(() {
                              _isMoveCountLimit = x;
                              print(_isMoveCountLimit);
                            });
                          },
                          children: <Widget>[
                            Container(
                              child: SpinBox(
                                min: 1,
                                max: 50,
                                value: _moveCountLimitNum.toDouble(),
                                onChanged: (value) {
                                  state(() {
                                    _moveCountLimitNum = value.toInt();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        ExpansionTile(
                          initiallyExpanded: _isItemCountLimit,
                          title: Text(
                            "${_isItemCountLimit ? "(o)" : "(X)"} 아이템 사용 제한",
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          onExpansionChanged: (x) {
                            state(() {
                              _isItemCountLimit = x;
                              // print(_isMoveCountLimit);
                            });
                          },
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        state(() {
                                          _itemCountLimitItem = ItemData.getItemDataList()[
                                              (ItemData.getItemDataList().indexOf(_itemCountLimitItem) -
                                                      1 +
                                                      ItemData.getItemDataList().length) %
                                                  ItemData.getItemDataList().length];

                                          print(_itemCountLimitItem);
                                        });
                                      },
                                      child: Icon(
                                        Icons.chevron_left,
                                        size: gs.s1(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                        decoration: BoxDecoration(
                                          color:
                                              true ? Color.fromRGBO(245, 245, 245, 1) : Color.fromRGBO(240, 240, 240, 0.8),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Image.asset(
                                          _itemCountLimitItem.imagePath,
                                          width: 40,
                                        )),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        state(() {
                                          _itemCountLimitItem = ItemData.getItemDataList()[
                                              (ItemData.getItemDataList().indexOf(_itemCountLimitItem) +
                                                      1 +
                                                      ItemData.getItemDataList().length) %
                                                  ItemData.getItemDataList().length];

                                          print(_itemCountLimitItem);
                                        });
                                      },
                                      child: Icon(
                                        Icons.chevron_right,
                                        size: gs.s1(),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: SpinBox(
                                    min: 0,
                                    max: 10,
                                    value: _itemCountLimitNum.toDouble(),
                                    decoration: InputDecoration(
                                        // suffixText:'개 이하',
                                        ),
                                    onChanged: (value) {
                                      state(() {
                                        _itemCountLimitNum = value.toInt();
                                      });
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: primaryYellow,
                                size: gs.s2(),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  gs.getLevelStarInfo(psc: [pCondition]).keys.toList()[0],
                                  style: TextStyle(
                                    fontSize: gs.s5(),
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: CustomButton(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("설정 완료",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                            backgroundColor: Color.fromRGBO(210, 210, 210, 0.8),
                            onTap: () {
                              setState(() {
                                _currentLevelData.pStarCondition[pConditionIndex] = pCondition;
                                print("fsdfsd");
                                print(_currentLevelData.pStarCondition);
                                gs.levelData = _currentLevelData;
                                yy.dismiss();
                              });
                            },
                          ),
                        ),
                      ]);
                    });
                  }),
                ],
              )),
            )
          ],
        ))
        ..animatedFunc = (child, animation) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(
                0.0,
                Tween<double>(begin: -50.0, end: 0)
                    .animate(
                      CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                    )
                    .value,
              )
              ..scale(
                Tween<double>(begin: 0, end: 1.0)
                    .animate(
                      CurvedAnimation(curve: Curves.easeOut, parent: animation),
                    )
                    .value,
              ),
            child: child,
          );
        }
        ..show();
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
                children: [
                  MapInstance.eraserObject,
                  MapInstance.playerObject,
                  MapInstance.personObject,
                  MapInstance.goalObject
                ].map((x) {
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
        contentWidget = Container(
            // height: 1000,
            child: ListView(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [ItemData.isolate, ItemData.release, ItemData.vaccine, ItemData.diagonal].map((x) {
                  // bool isSelectedInstance = gs.selectedMapInstance == x;

                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                color: true ? Color.fromRGBO(245, 245, 245, 1) : Color.fromRGBO(240, 240, 240, 0.8),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Image.asset(
                                x.imagePath,
                                width: gs.s2(),
                              )),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text(
                                    x.caption,
                                    style: TextStyle(fontSize: gs.s5()),
                                  )),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_currentLevelData.items == null) {
                                            _currentLevelData.items = {x.name: 1};
                                          } else {
                                            if (_currentLevelData.items.containsKey(x.name)) {
                                              if (_currentLevelData.items[x.name] < 10) {
                                                _currentLevelData.items[x.name] += 1;
                                              }
                                            } else {
                                              _currentLevelData.items[x.name] = 1;
                                            }
                                          }

                                          // gs.levelData = _currentLevelData;
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_up,
                                        size: gs.s1(),
                                      )),
                                  Text(
                                    gs.getEditModeItemCount(ld: _currentLevelData, itemName: x.name).toString(),
                                    style: TextStyle(fontSize: gs.s5()),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_currentLevelData.items == null) {
                                            _currentLevelData.items = {x.name: 0};
                                          } else {
                                            if (_currentLevelData.items.containsKey(x.name)) {
                                              if (_currentLevelData.items[x.name] > 0) {
                                                _currentLevelData.items[x.name] -= 1;
                                              }
                                            } else {
                                              _currentLevelData.items[x.name] = 0;
                                            }
                                          }

                                          // gs.levelData = _currentLevelData;
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: gs.s1(),
                                      )),
                                ],
                              )
                            ],
                          ))
                        ],
                      ));
                }).toList()));
      } else if (tabIndex == 3) {
        contentWidget = Container(
            // height: 1000,
            child: ListView(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [0, 1, 2].map((pStarConditionIndex) {
                  // bool isSelectedInstance = gs.selectedMapInstance == x;

                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                        color: pStarConditionIndex == 0 ? Colors.grey.withOpacity(0.4) : Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: primaryYellow,
                            size: gs.s5(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: pStarConditionIndex == 0
                                ? null
                                : () {
                                    showEditStarConditionDialog(context: context, pConditionIndex: pStarConditionIndex);
                                  },
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    gs.getLevelStarInfo(getOnlyStr: true)[pStarConditionIndex],
                                    style: TextStyle(fontSize: gs.s5()),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ));
                }).toList()));
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

  dynamic showCustomLevelModifySizeDialog({BuildContext context}) {
    GlobalStatus gs = Provider.of<GlobalStatus>(context, listen: false);
    var yy = YYDialog();

    return yy.build(context)
      ..barrierDismissible = true
      ..width = gs.deviceSize.width * 0.9
      ..backgroundColor = Colors.white12.withOpacity(1)
      ..duration = Duration(milliseconds: 400)
      ..widget(Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // width: gs.deviceS,

            child: Container(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("맵 크기 수정", style: TextStyle(fontSize: gs.s4())),
                Builder(builder: (context) {
                  int _mapWidth = gs.levelData.mapWidth;
                  int _mapHeight = gs.levelData.mapHeight;

                  return StatefulBuilder(builder: (BuildContext bc, StateSetter state) {
                    return Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    "가로",
                                    style: TextStyle(fontSize: gs.s3()),
                                  ),
                                  Container(
                                    width: 300,
                                    child: SpinBox(
                                      min: 3,
                                      max: 8,
                                      value: _mapWidth.toDouble(),
                                      onChanged: (value) {
                                        state(() {
                                          _mapWidth = value.toInt();
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    "세로",
                                    style: TextStyle(fontSize: gs.s3()),
                                  ),
                                  Container(
                                    width: 300,
                                    child: SpinBox(
                                      min: 3,
                                      max: 8,
                                      value: _mapHeight.toDouble(),
                                      onChanged: (value) {
                                        state(() {
                                          _mapHeight = value.toInt();
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: CustomButton(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check, size: gs.s3()),
                                SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Text("설정 완료",
                                      style: TextStyle(
                                        fontSize: gs.s5(),
                                      )),
                                ),
                              ],
                            ),
                            backgroundColor: Color.fromRGBO(210, 210, 210, 0.8),
                            onTap: () {
                              LevelData initLevelData;

                              initLevelData = LevelData.fromJson({
                                "seq": 9999999,
                                "mapWidth": _mapWidth,
                                "mapHeight": _mapHeight,
                                "map": List.generate(_mapHeight, (i) {
                                  return List.generate(_mapWidth, (j) {
                                    return 0;
                                  });
                                }),
                                "confined": List.generate(_mapHeight, (i) {
                                  return List.generate(_mapWidth, (j) {
                                    return 0;
                                  });
                                }),
                                "isolated": List.generate(_mapHeight, (i) {
                                  return List.generate(_mapWidth, (j) {
                                    return 0;
                                  });
                                }),
                                "pStarCondition": ["clear", "move 5 & clear", "move 8 & no vaccine & clear"]
                              });

                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                FadeRoute(
                                    page: RouterPage(
                                        page: MapEditPage(
                                  tempLevelData: initLevelData,
                                ))),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  });
                }),
              ],
            )),
          )
        ],
      ))
      ..animatedFunc = (child, animation) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(
              0.0,
              Tween<double>(begin: -50.0, end: 0)
                  .animate(
                    CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                  )
                  .value,
            )
            ..scale(
              Tween<double>(begin: 0, end: 1.0)
                  .animate(
                    CurvedAnimation(curve: Curves.easeOut, parent: animation),
                  )
                  .value,
            ),
          child: child,
        );
      }
      ..show();
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                        gs.isEditMode = true;
                        gs.notify();

                        // Navigator.pushReplacement(
                        //   context,
                        //   FadeRoute(page: MapEditPage()),
                        // );

                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          FadeRoute(page: RouterPage(page: MapEditPage())),
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
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                        showCustomLevelModifySizeDialog(context: context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Icon(Icons.zoom_out_map),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();

                        gs.currentGameMode = GameMode.CUSTOM_LEVEL_EDITING;
                        gs.isEditMode = false;

                        gs.tempCustomLevelData = _currentLevelData;

                        List<String> validateErrorList = gs.validateCustomLevel(customLevelData: _currentLevelData);
                        if (validateErrorList.length > 0) {
                          showCustomToast(validateErrorList[0], ToastType.small);
                        } else {
                          moveToLevel(
                              context: context,
                              isSkipTutorial: true,
                              isCustomLevel: true,
                              customLevelData: _currentLevelData);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Icon(Icons.gamepad_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();

                        publishCustomLevel(context: context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Icon(Icons.public),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                        gs.isEditMode = false;
                        gs.notify();
                        Navigator.pushReplacement(
                          context,
                          FadeRoute(page: HomePage()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Icon(Icons.exit_to_app),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
