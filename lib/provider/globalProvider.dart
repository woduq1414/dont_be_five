import 'package:dont_be_five/data/Direction.dart';
import 'package:dont_be_five/data/HighlightTile.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/SelectMode.dart';
import 'package:dont_be_five/data/SelectType.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/widget/Tile.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

import 'package:vibration/vibration.dart';

class GlobalStatus with ChangeNotifier {
//  KakaoContext.clientId = '39d6c43a0a346cca6ebc7b2dbb8e4353';

  bool _isGameEnd = false;


  bool get isGameEnd => _isGameEnd;

  set isGameEnd(bool value) {
    _isGameEnd = value;
  }

  BuildContext context;



  void printAllPersonData() {
    for (PersonData p in personDataList) {
      print("${p.x} ${p.y} : ${p.idx} / ${p.count} : ${p.hash}");
    }
  }

  bool isIsolated({TileData tile}) {
    for (TileData t in _isolatedTileList) {
      if (t.x == tile.x && t.y == tile.y) {
        return true;
      }
    }
    return false;
  }

  List<TileData> _isolatedTileList = [];

  List<TileData> get isolatedTileList => _isolatedTileList;

  set isolatedTileList(List<TileData> value) {
    _isolatedTileList = value;
  }

  ItemData _selectedItem;

  ItemData get selectedItem => _selectedItem;

  set selectedItem(ItemData value) {
    _selectedItem = value;
  }

  void selectItem(ItemData item) {
    selectMode = SelectMode.itemTargetSelect;
    Set<TileData> tempSet = Set();
    _highlightTileMap[HighlightTile.selectable] = [];
    _highlightTileMap[HighlightTile.selected] = [];
    _highlightTileMap[HighlightTile.moveable] = [];

    if (item == null) {
      _highlightTileMap[HighlightTile.selectable] = [];
      _selectedItem = null;
      return;
    }

    if (_levelData.items[item.name] <= 0) {
      return;
    }
    selectedItem = item;
    if (item == ItemData.isolate) {
      for (int i = 0; i < _levelData.mapHeight; i++) {
        for (int j = 0; j < _levelData.mapWidth; j++) {
          Tiles tileType = Tiles.getTileType(tile: TileData(x: j, y: i), levelData: levelData);
          if (tileType == Tiles.person || tileType == Tiles.player) {
            if (!isIsolated(tile: TileData(x: j, y: i))) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
      }

      if(_highlightTileMap[HighlightTile.selectable].length == 0){
        showCustomToast("자가격리 대상이 없습니다.", ToastType.small);
        _highlightTileMap[HighlightTile.selectable] = [];
        _selectedItem = null;
      }else{
        showCustomToast("자가격리 대상을 선택해주세요.", ToastType.small);
      }

    } else if (item == ItemData.release) {
      _highlightTileMap[HighlightTile.selectable] = _isolatedTileList;
      if(_highlightTileMap[HighlightTile.selectable].length == 0){
        showCustomToast("자가격리 해제 대상이 없습니다.", ToastType.small);
        _highlightTileMap[HighlightTile.selectable] = [];
        _selectedItem = null;
      }else{
        showCustomToast("자가격리 해제 대상을 선택해주세요.", ToastType.small);
      }
    } else if (item == ItemData.vaccine) {
      for (int i = 0; i < _levelData.mapHeight; i++) {
        for (int j = 0; j < _levelData.mapWidth; j++) {
          Tiles tileType = Tiles.getTileType(tile: TileData(x: j, y: i), levelData: levelData);
          if (tileType == Tiles.person) {
            _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
          }
        }
      }
      if(_highlightTileMap[HighlightTile.selectable].length == 0){
        showCustomToast("백신 투약 대상이 없습니다.", ToastType.small);
        _highlightTileMap[HighlightTile.selectable] = [];
        _selectedItem = null;
      }else{
        showCustomToast("백신 투약 대상을 선택해주세요.", ToastType.small);
      }
    } else {}



    notifyListeners();
  }

  double s1() {
    return _deviceSize.width * 0.1;
  }

  double s2() {
    return _deviceSize.width * 0.08;
  }

  double s3() {
    return _deviceSize.width * 0.06;
  }

  double s4() {
    return _deviceSize.width * 0.05;
  }

  double s5() {
    return _deviceSize.width * 0.04;
  }

  double s6() {
    return _deviceSize.width * 0.03;
  }

  double s7() {
    return _deviceSize.width * 0.02;
  }

  double s8() {
    return _deviceSize.width * 0.01;
  }

  double s9() {
    return _deviceSize.width * 0.008;
  }

  Size _deviceSize;

  Size get deviceSize => _deviceSize;

  set deviceSize(Size value) {
    _deviceSize = value;
  }

  TileData _goalTile;

  TileData get goalTile => _goalTile;

  set goalTile(TileData value) {
    _goalTile = value;
  }

  SelectMode _selectMode = SelectMode.normal;

  SelectMode get selectMode => _selectMode;

  set selectMode(SelectMode value) {
    _selectMode = value;
  }

  void selectTile({TileData tile, SelectType selectType}) {
    if (selectType == SelectType.personSelect) {
      if (_selectedTile != null && _selectedTile.x == tile.x && _selectedTile.y == tile.y) {
        _selectedTile = null;
        _highlightTileMap[HighlightTile.moveable] = [];
        _highlightTileMap[HighlightTile.selected] = [];
        _highlightTileMap[HighlightTile.selectable] = [];
        return;
      }

      _selectedTile = tile;
      _highlightTileMap[HighlightTile.selected] = [];
      _highlightTileMap[HighlightTile.moveable] = [];
      _highlightTileMap[HighlightTile.selectable] = [];

      if (!(Tiles.getTileType(tile: tile, levelData: _levelData) == Tiles.player ||
          Tiles.getTileType(tile: tile, levelData: _levelData) == Tiles.person)) {
        return;
      }

      if (isIsolated(tile: tile)) {
        showCustomToast("자가격리 중입니다!", ToastType.normal);
        return;
      }

      for (Direction d in [Direction.down, Direction.left, Direction.right, Direction.up]) {
        TileData destTile = TileData(x: tile.x + d.x, y: tile.y + d.y);

        if (isSelectableTile(tile: destTile, selectMode: SelectMode.move)) {
          Tiles tileType = Tiles.getTileType(tile: tile, levelData: _levelData);
          Tiles destTileType = Tiles.getTileType(tile: destTile, levelData: _levelData);
          if (!(tileType == Tiles.player && destTileType == Tiles.person) &&
              !(tileType == Tiles.person && destTileType == Tiles.player)) {
            _highlightTileMap[HighlightTile.moveable].add(destTile);
          }
        }
      }

      _highlightTileMap[HighlightTile.selected] = [tile];

      _selectMode = SelectMode.move;
    } else if (selectType == SelectType.personMove) {
      bool isTargetTile = _highlightTileMap[HighlightTile.moveable]
                  .where((element) => element.x == tile.x && element.y == tile.y)
                  .toList()
                  .length !=
              0
          ? true
          : false;
      // print( _availableTileList.where((element) => element.x == tile.x && element.y == tile.y).toList().length);

      if (isTargetTile) {
        Direction d = Direction(tile.x - _selectedTile.x, tile.y - _selectedTile.y);

        movePerson(tile: selectedTile, d: d);
      } else {
        selectTile(tile: tile, selectType: SelectType.personSelect);
      }

      // _selectMode = SelectMode.normal;

    } else if (selectType == SelectType.itemTargetSelect) {
      bool isTargetTile = _highlightTileMap[HighlightTile.selectable]
                  .where((element) => element.x == tile.x && element.y == tile.y)
                  .toList()
                  .length !=
              0
          ? true
          : false;
      // print( _availableTileList.where((element) => element.x == tile.x && element.y == tile.y).toList().length);

      if (isTargetTile) {
        _highlightTileMap[HighlightTile.selectable] = [];

        if (selectedItem == ItemData.isolate) {
          _isolatedTileList.add(tile);
          _highlightTileMap[HighlightTile.isolated].add(tile);
          _levelData.items[selectedItem.name] -= 1;

          showCustomToast("자가격리!", ToastType.normal);
        } else if (selectedItem == ItemData.release) {
          _isolatedTileList.removeWhere((element) => element.x == tile.x && element.y == tile.y);
          _highlightTileMap[HighlightTile.isolated].removeWhere((element) => element.x == tile.x && element.y == tile.y);
          notifyListeners();
          if (isFive(tile: tile)) {
            _isolatedTileList.add(tile);
            Future.delayed(const Duration(milliseconds: 350), () {
              _highlightTileMap[HighlightTile.isolated].add(tile);
              notifyListeners();
            });
          } else {
            _levelData.items[selectedItem.name] -= 1;
            showCustomToast("자가격리 해제!", ToastType.normal);
          }
        } else if (selectedItem == ItemData.vaccine) {
          _personDataList
              .removeWhere((p) => (p.x == tile.x && p.y == tile.y && p.idx == _levelData.map[tile.y][tile.x] - 1));

          _levelData.map[tile.y][tile.x] -= 1;
          _levelData.items[selectedItem.name] -= 1;
          showCustomToast("백신 투약!", ToastType.normal);
        }
      } else {
        selectTile(tile: tile, selectType: SelectType.personSelect);
      }

      _selectedItem = null;

      // _selectMode = SelectMode.normal;

    }
    notifyListeners();
  }

  bool isSelectableTile({TileData tile, SelectMode selectMode}) {
    TileData t = tile;

    if (isIsolated(tile: tile)) {
      return false;
    }

    if (selectMode == SelectMode.normal) {
      return t.x >= 0 &&
          t.x < _levelData.mapWidth &&
          t.y >= 0 &&
          t.y < _levelData.mapHeight &&
          _levelData.map[t.y][t.x] != -1;
    } else if (selectMode == SelectMode.move) {
      return t.x >= 0 &&
          t.x < _levelData.mapWidth &&
          t.y >= 0 &&
          t.y < _levelData.mapHeight &&
          _levelData.map[t.y][t.x] != -1;
    } else {
      return false;
    }
  }

  TileData _selectedTile;

  TileData get selectedTile => _selectedTile;

  set selectedTile(TileData value) {
    _selectedTile = value;
  }

  Map<String, List<TileData>> _highlightTileMap = {};

  Map<String, List<TileData>> get availableTileList => _highlightTileMap;

  set availableTileList(Map<String, List<TileData>> value) {
    _highlightTileMap = value;
  }

  List<dynamic> _personDataList;

  List<dynamic> get personDataList => _personDataList;

  set personDataList(List<dynamic> value) {
    _personDataList = value;
  }

  List<LevelData> levelDataList;
  List<Person> _personList;

  List<Person> get personList => _personList;

  set personList(List<Person> value) {
    _personList = value;
    notifyListeners();
  }

  int currentLevel = 0;

  LevelData _levelData;

  GlobalStatus() {
    init();
  }

  init() async {
    Map<String, dynamic> data = await parseJsonFromAssets('assets/json/levelData.json');
    levelDataList = data["levels"].map<LevelData>((x) => LevelData.fromJson(x)).toList();

    notifyListeners();
  }

  List<dynamic> _tileCornerOffsetList;

  LevelData get levelData => _levelData;

  set levelData(LevelData value) {
    _levelData = value;
    notifyListeners();
  }

  List<dynamic> get tileCornerOffsetList => _tileCornerOffsetList;

  set tileCornerOffsetList(List<dynamic> value) {
    _tileCornerOffsetList = value;
    notifyListeners();
  }

  bool isDestinationAbleTile(TileData t) {
    return t.x >= 0 && t.x < _levelData.mapWidth && t.y >= 0 && t.y < _levelData.mapHeight && _levelData.map[t.y][t.x] != -1;
  }

  void initLevel() {
    _isGameEnd = false;
    _highlightTileMap = {
      HighlightTile.selected: [],
      HighlightTile.moveable: [],
      HighlightTile.five: [],
      HighlightTile.isolated: [],
      HighlightTile.selectable: [],
    };
    _isolatedTileList = [];
    _selectedTile = null;
    _personDataList = [];
    _selectedItem = null;
    _selectMode = SelectMode.normal;
  }

  void movePerson({TileData tile, Direction d}) async {
    int x = tile.x;
    int y = tile.y;

    LevelData tempLevelData = _levelData.clone();
    List<PersonData> tempPersonDataList = _personDataList.map<PersonData>((x) {
      return x.clone();
    }).toList();

    if (!isDestinationAbleTile(TileData(x: x + d.x, y: y + d.y))) {
      return;
    }
    // List<Person> targetPersonList = _personList.indexWhere((el) => el.x == x && el.y == y);
    List<PersonData> destPersonList = _personDataList.where((el) => el.x == x + d.x && el.y == y + d.y).toList();

    TileData destTile = TileData(x: x + d.x, y: y + d.y);
    Tiles destTileType = Tiles.getTileType(tile: destTile, levelData: _levelData);

    if (destTileType == Tiles.person || destTileType == Tiles.block) {
      _levelData.map[y + d.y][x + d.x] = _levelData.map[y][x] + _levelData.map[y + d.y][x + d.x];
    } else if (destTileType == Tiles.player) {
      _levelData.map[y + d.y][x + d.x] = _levelData.map[y][x] + (_levelData.map[y + d.y][x + d.x] - 100);
    } else if (x + d.x == goalTile.x && y + d.y == goalTile.y) {
      _levelData.map[y + d.y][x + d.x] = _levelData.map[y][x];
    }

    _levelData.map[y][x] = 0;

    for (PersonData p in _personDataList) {
      if (p.x == x && p.y == y) {
        p.x = x + d.x;
        p.y = y + d.y;
        p.idx = p.idx + destPersonList.length;
      }
    }

    // _personList[0].x = 1;
    // _personList[0].y = 0;

    // print(targetPersonList);

    notifyListeners();

    if (isFive(tile: destTile)) {
      _selectedTile = null;
      _highlightTileMap[HighlightTile.selected] = [];
      _highlightTileMap[HighlightTile.moveable] = [];

      Future.delayed(const Duration(milliseconds: 350), () {
        _personDataList = tempPersonDataList;
        _levelData = tempLevelData;
        notifyListeners();
      });
    } else {
      _selectedTile = null;
      _highlightTileMap[HighlightTile.selected] = [];
      _highlightTileMap[HighlightTile.moveable] = [];

      if (isGoal()) {

        print("goal!");
        Future.delayed(const Duration(milliseconds: 350), () {
          Vibration.vibrate(duration: 1000);
          _isGameEnd = true;
          notifyListeners();
        });




        // showGoalDialog(context);





      }else{
        Future.delayed(const Duration(milliseconds: 350), () {
          selectTile(tile: destTile, selectType: SelectType.personSelect);
        });
      }


    }
  }

  bool isGoal() {
    for(int i = 0 ; i < _levelData.mapHeight; i ++){
      for(int j = 0; j < _levelData.mapWidth ; j++){
        if(Tiles.getTileType(tile: TileData(x:j, y:i), levelData: levelData) == Tiles.player){
          if(!(_goalTile.x == j &&  _goalTile.y == i)){
            return false;
          }
        }
      }
    }
    return true;


  }

  bool isFive({TileData tile}) {
    bool fiveFlag = false;
    for (Direction d in [Direction(0, 0), Direction.down, Direction.left, Direction.right, Direction.up]) {
      TileData destTile = TileData(x: tile.x + d.x, y: tile.y + d.y);
      int cnt = 0;

      if (isSelectableTile(tile: destTile, selectMode: SelectMode.move)) {
        Tiles destTileType = Tiles.getTileType(tile: destTile, levelData: _levelData);
        if (destTileType != Tiles.person && destTileType != Tiles.player) {
          continue;
        }

        cnt += Tiles.getTilePersonCount(tile: destTile, levelData: _levelData);
        for (Direction dd in [Direction.down, Direction.left, Direction.right, Direction.up]) {
          TileData destTile_2 = TileData(x: destTile.x + dd.x, y: destTile.y + dd.y);
          if (isSelectableTile(tile: destTile_2, selectMode: SelectMode.move)) {
            cnt += Tiles.getTilePersonCount(tile: destTile_2, levelData: _levelData);
          }
        }
        if (cnt >= 5) {
          print("five!!!!!!!!!!!1");
          fiveFlag = true;

          _highlightTileMap[HighlightTile.five].add(destTile);
          for (Direction dd in [Direction.down, Direction.left, Direction.right, Direction.up]) {
            TileData destTile_2 = TileData(x: destTile.x + dd.x, y: destTile.y + dd.y);
            if (isSelectableTile(tile: destTile_2, selectMode: SelectMode.move)) {
              _highlightTileMap[HighlightTile.five].add(destTile_2);
            }
          }
        }
      }
    }
    Future.delayed(const Duration(milliseconds: 350), () {
      _highlightTileMap[HighlightTile.five] = [];
    });

    if (fiveFlag) {
      Vibration.vibrate(duration: 300);
      showCustomToast("5인 이상 집합 금지!", ToastType.normal);
    }

    return fiveFlag;
  }
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}
