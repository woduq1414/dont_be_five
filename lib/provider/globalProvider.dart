import 'package:dont_be_five/data/Direction.dart';
import 'package:dont_be_five/data/HighlightTile.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/SelectMode.dart';
import 'package:dont_be_five/data/SelectType.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/widget/Tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

import 'package:vibration/vibration.dart';

class GlobalStatus with ChangeNotifier {
//  KakaoContext.clientId = '39d6c43a0a346cca6ebc7b2dbb8e4353';

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
        return;
      }

      _selectedTile = tile;
      _highlightTileMap[HighlightTile.selected] = [];
      _highlightTileMap[HighlightTile.moveable] = [];

      if (!(Tiles.getTileType(tile: tile, levelData: _levelData) == Tiles.player ||
          Tiles.getTileType(tile: tile, levelData: _levelData) == Tiles.person)) {
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

      print(_highlightTileMap);
      _selectMode = SelectMode.move;
    } else if (selectType == SelectType.personMove) {
      print(_highlightTileMap);

      bool isTargetTile = _highlightTileMap[HighlightTile.moveable]
                  .where((element) => element.x == tile.x && element.y == tile.y)
                  .toList()
                  .length !=
              0
          ? true
          : false;
      // print( _availableTileList.where((element) => element.x == tile.x && element.y == tile.y).toList().length);
      print(isTargetTile);

      if (isTargetTile) {
        print("@@@@@@@@@@@@@@@@@@@@@@22");
        Direction d = Direction(tile.x - _selectedTile.x, tile.y - _selectedTile.y);

        movePerson(tile: selectedTile, d: d);
      } else {
        selectTile(tile: tile, selectType: SelectType.personSelect);
      }

      // _selectMode = SelectMode.normal;

    }
    notifyListeners();
  }

  bool isSelectableTile({TileData tile, SelectMode selectMode}) {
    TileData t = tile;
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
    _highlightTileMap = {
      HighlightTile.selected: [],
      HighlightTile.moveable: [],
      HighlightTile.five: [],
    };
    _selectedTile = null;
    _personDataList = [];
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
        Vibration.vibrate(duration: 1000);
      }

      Future.delayed(const Duration(milliseconds: 350), () {
        selectTile(tile: destTile, selectType: SelectType.personSelect);
      });
    }
  }

  bool isGoal() {
    return Tiles.getTileType(tile: _goalTile, levelData: _levelData) == Tiles.player;
  }

  bool isFive({TileData tile}) {
    bool fiveFlag = false;
    for (Direction d in [Direction(0,0), Direction.down, Direction.left, Direction.right, Direction.up]) {
      TileData destTile = TileData(x: tile.x + d.x, y: tile.y + d.y);
      int cnt = 0;

      if (isSelectableTile(tile: destTile, selectMode: SelectMode.move)) {

        Tiles destTileType = Tiles.getTileType(tile:destTile, levelData:_levelData);
        if(destTileType != Tiles.person && destTileType != Tiles.player){
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
    return fiveFlag;
  }
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}
