import 'dart:io';
import 'package:dont_be_five/data/MapInstance.dart';
import 'package:games_services/games_services.dart';
import 'package:dont_be_five/common/path.dart';
import 'package:dont_be_five/common/Counter.dart';
import 'package:dont_be_five/data/Direction.dart';
import 'package:dont_be_five/data/GameMode.dart';
import 'package:dont_be_five/data/HighlightTile.dart';
import 'package:dont_be_five/data/AchievementData.dart';
import 'package:dont_be_five/data/ItemData.dart';
import 'package:dont_be_five/data/LevelData.dart';
import 'package:dont_be_five/data/LevelDataJson.dart';
import 'package:dont_be_five/data/PersonData.dart';
import 'package:dont_be_five/data/hive/SaveData.dart';
import 'package:dont_be_five/data/SelectMode.dart';
import 'package:dont_be_five/data/SelectType.dart';
import 'package:dont_be_five/data/Tiles.dart';
import 'package:dont_be_five/data/ToastType.dart';
import 'package:dont_be_five/widget/Dialog.dart';
import 'package:dont_be_five/widget/Person.dart';
import 'package:dont_be_five/data/TileData.dart';
import 'package:dont_be_five/widget/Tile.dart';
import 'package:dont_be_five/widget/Toast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

import 'package:vibration/vibration.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class GlobalStatus with ChangeNotifier {
  ///////////////// GAME CONFIG

  bool _isDebug = false;

  bool get isDebug => _isDebug;

  set isDebug(bool value) {
    _isDebug = value;
  }

  double _volumeValue;
  String _isVibrate;

  double get volumeValue => _volumeValue;

  set volumeValue(double value) {
    _volumeValue = value;
    notifyListeners();
  }

  String get isVibrate => _isVibrate;

  set isVibrate(String value) {
    _isVibrate = value;
    notifyListeners();
  }

  ///////////////// GAME CONFIG

  ///////////////// GAME SYSTEM VAR

  bool _isRateDialogShowed = false;

  bool get isRateDialogShowed => _isRateDialogShowed;

  set isRateDialogShowed(bool value) {
    _isRateDialogShowed = value;
  }

  ///////////////// GAME SYSTEM VAR
  Box<SaveData> box;

  AudioCache _audioCache;

  AudioCache get audioCache => _audioCache;

  set audioCache(AudioCache value) {
    _audioCache = value;
  }

  Size _deviceSize;

  Size get deviceSize => _deviceSize;

  set deviceSize(Size value) {
    _deviceSize = value;
  }

  bool _isEditMode;

  bool get isEditMode => _isEditMode;

  set isEditMode(bool value) {
    _isEditMode = value;

    if (value == false) {
      // throw "no";
    }

    print("oh!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(value);
    // notify();
  } ///////////////// IN GAME MAP

  GameMode _currentGameMode;

  GameMode get currentGameMode => _currentGameMode;

  set currentGameMode(GameMode value) {
    _currentGameMode = value;
  }

  Counter _counter;

  Counter get counter => _counter;

  set counter(Counter value) {
    _counter = value;
  }

  Map<ItemData, dynamic> _usedItemCountMap;

  Map<ItemData, dynamic> get usedItemCountMap => _usedItemCountMap;

  set usedItemCountMap(Map<ItemData, dynamic> value) {
    _usedItemCountMap = value;
  }

  int _moveCount = 0;

  int get moveCount => _moveCount;

  set moveCount(int value) {
    _moveCount = value;
  }

  bool _isGameCleared;

  bool get isGameCleared => _isGameCleared;

  set isGameCleared(bool value) {
    _isGameCleared = value;
  }

  List<TileData> _confinedTileList = [];

  List<TileData> get confinedTileList => _confinedTileList;

  set confinedTileList(List<TileData> value) {
    _confinedTileList = value;
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

  bool _isDiagonalMove = false;

  bool get isDiagonalMove => _isDiagonalMove;

  set isDiagonalMove(bool value) {
    _isDiagonalMove = value;
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

  List<PersonData> _personDataList;

  List<PersonData> get personDataList => _personDataList;

  set personDataList(List<PersonData> value) {
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



  Map<String, List<TileData>> get highlightTileMap => _highlightTileMap;

  set highlightTileMap(Map<String, List<TileData>> value) {
    _highlightTileMap = value;
  }

  ///////////////// IN GAME MAP

  ///////////////// IN EDIT MAP

  MapInstance _selectedMapInstance;

  MapInstance get selectedMapInstance => _selectedMapInstance;

  set selectedMapInstance(MapInstance value) {
    _selectedMapInstance = value;

    updateEditAvailableTile();
  }

  bool _isRenewPersonBuilder = false;

  bool get isRenewPersonBuilder => _isRenewPersonBuilder;

  set isRenewPersonBuilder(bool value) {
    _isRenewPersonBuilder = value;
  }

  LevelData _tempCustomLevelData;

  LevelData get tempCustomLevelData => _tempCustomLevelData;

  set tempCustomLevelData(LevelData value) {
    _tempCustomLevelData = value;
  }

  bool _isCustomLevelTestCompleted = false;


  bool get isCustomLevelTestCompleted => _isCustomLevelTestCompleted;

  set isCustomLevelTestCompleted(bool value) {
    _isCustomLevelTestCompleted = value;
  }

  LevelData _testedLevelData;


  LevelData get testedLevelData => _testedLevelData;

  set testedLevelData(LevelData value) {
    _testedLevelData = value;
  } //////////////// IN EDIT MAP

  List<String> validateCustomLevel({LevelData customLevelData}){

    int playerCount = 0;
    int goalCount = 0;

    List<String> result = [];

    for(int i = 0 ; i < customLevelData.mapHeight; i++){
      for(int j = 0 ; j < customLevelData.mapWidth; j++){
        int tileValue = customLevelData.map[i][j];
        if(101 <= tileValue && tileValue <= 104){
          playerCount += tileValue - 100;
        }
        if(999999 == tileValue){
          goalCount += 1;
        }
      }
    }

    if(playerCount == 0){
      result.add("플레이어는 1개 이상이어야 합니다.");
    }
    if(goalCount != 1){
      result.add("목적지는 1개 존재해야 합니다.");
    }
    if(isFiveAll()){
      result.add("<5인 이상 집합 금지>에 어긋난 타일이 있는 지 확인해주세요.");
    }
    return result;

  }



  int getEditModeItemCount({LevelData ld, String itemName}) {
    if (ld.items == null) {
      return 0;
    }
    if (ld.items.containsKey(itemName)) {
      return ld.items[itemName];
    } else {
      return 0;
    }
  }

  void notify() {
    notifyListeners();
  }

  void updateEditAvailableTile() {
    _highlightTileMap[HighlightTile.selectable] = [];
    switch (selectedMapInstance) {
      case MapInstance.blankTile:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] >= 0) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;
      case MapInstance.blockTile:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] == -1) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;
      case MapInstance.isolatedTile:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] != -1) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;

      case MapInstance.confinedTile:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] != -1) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;

      case MapInstance.eraserObject:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] >= 1) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;

      case MapInstance.playerObject:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] == 0 || (_levelData.map[i][j] >= 101 && _levelData.map[i][j] <= 103)) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;

      case MapInstance.personObject:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] == 0 || (_levelData.map[i][j] >= 1 && _levelData.map[i][j] <= 3)) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;

      case MapInstance.goalObject:
        for (int i = 0; i < _levelData.mapHeight; i++) {
          for (int j = 0; j < _levelData.mapWidth; j++) {
            if (_levelData.map[i][j] == 0) {
              _highlightTileMap[HighlightTile.selectable].add(TileData(x: j, y: i));
            }
          }
        }
        break;
    }

    notifyListeners();
  }

  int getLastUnlockedLevel() {
    SaveData saveData = box.get('saveData');
    for (int i = 0; i < saveData.levelProcessList.length; i++) {
      if (saveData.levelProcessList[i] == -1) {
        return i;
      }
    }
    return saveData.levelProcessList.length;
  }

  void unlockAllLevel() async {
    List<int> originalLevelProcessList = getLevelProcessList();

    List<int> levelProcessList = List.generate(300, (index) {
      return originalLevelProcessList[index] > 0 ? originalLevelProcessList[index] : 0;
    });
    SaveData saveData = box.get('saveData');
    saveData.levelProcessList = levelProcessList;
    saveData.save();
  }

  void clearProcess() async {
    Map<String, dynamic> levelStarInfo = getLevelStarInfo();
    print("dffddffd");
    print(getLevelStarInfo());
    List<int> levelProcessList = getLevelProcessList();
    int originLevelStatus = levelProcessList[levelData.seq - 1];

    List<bool> havingStar = [];
    havingStar.add(originLevelStatus % 2 == 1);
    havingStar.add(originLevelStatus ~/ 2 % 2 == 1);
    havingStar.add(originLevelStatus ~/ 4 % 2 == 1);

    for (int i = 0; i < levelStarInfo.keys.length; i++) {
      if (levelStarInfo[levelStarInfo.keys.toList()[i]] == true) {
        havingStar[i] = true;
      }
    }

    levelProcessList[levelData.seq - 1] =
        (havingStar[0] ? 1 : 0) + (havingStar[1] ? 1 : 0) * 2 + (havingStar[2] ? 1 : 0) * 4;

    levelProcessList[levelData.seq] = levelProcessList[levelData.seq] == -1 ? 0 : levelProcessList[levelData.seq];

    SaveData saveData = box.get('saveData');
    saveData.levelProcessList = levelProcessList;
    saveData.save();

    int level = levelData.seq;
    if (level == 1) {
      GamesServices.unlock(achievement: Achievement(androidID: AchievementData.helloWorld));
    } else if (level == 12) {
      GamesServices.unlock(achievement: Achievement(androidID: AchievementData.socialDistancing1));
    } else if (level == 24) {
      GamesServices.unlock(achievement: Achievement(androidID: AchievementData.socialDistancing2));
    } else if (level == 30) {
      GamesServices.unlock(achievement: Achievement(androidID: AchievementData.socialDistancing2_5));
    } else if (level == 42) {
      GamesServices.unlock(achievement: Achievement(androidID: AchievementData.socialDistancing2_5_a));
    }

    if (counter.getValue("five") >= 19) {
      GamesServices.unlock(achievement: Achievement(androidID: AchievementData.disobedient));
    }
  }

  List<int> getLevelProcessList() {
    SaveData saveData = box.get('saveData');
    return saveData.levelProcessList;
  }

  int getTotalStarCount() {
    List<int> levelProcessList = getLevelProcessList();
    int cnt = 0;
    for (int i = 0; i < levelProcessList.length; i++) {
      if (levelProcessList[i] > 0) {
        if (levelProcessList[i] % 2 == 1) {
          cnt += 1;
        }
        if (levelProcessList[i] ~/ 2 % 2 == 1) {
          cnt += 1;
        }
        if (levelProcessList[i] ~/ 4 % 4 == 1) {
          cnt += 1;
        }
      }
    }

    return cnt;
  }

  void loadSaveData() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(SaveDataAdapter());
    } catch (e) {}

    box = await Hive.openBox('saved');
    // box.clear();

    SaveData saveData = box.get('saveData');
    if (saveData == null) {
      print("null..");
      await initSaveData();
      saveData = box.get('saveData');
    }
    print("SDDDDDDD");
    print(saveData);

    notifyListeners();

    // var savedDat = SaveData()
    //   ..levelProcessList = List.generate(100, (index) {return 0;});
    //
    // await box.put('saved', person);
  }

  Future<void> initSaveData() async {
    box = await Hive.openBox('saved');
    var saveData = SaveData()
      ..levelProcessList = List.generate(300, (index) {
        return index == 0 ? 0 : -1;
      });

    await box.put('saveData', saveData);
    print(box.get('saveData'));
  }

  dynamic getLevelStarInfo({List<String> psc, bool getOnlyStr = false}) {
    Map<String, dynamic> result = {};
    List<String> strList = [];

    List<String> pStarCondition;
    if (psc == null) {
      pStarCondition = levelData.pStarCondition;
      print(pStarCondition);
    } else {
      pStarCondition = psc;
    }

    if(_isGameCleared){
      print("wowclearaed");
    }else{
      print("nonono");
    }

    for (String sc in pStarCondition) {
      bool boo = true;

      String str = "";
      List<String> condList = sc.split("&").map((x) {
        return x.trim();
      }).toList();
      for (String cond in condList) {
        String stopWord = cond.split(" ")[0];
        switch (stopWord) {
          case "clear":
            str += "클리어";
            if (_isGameCleared) {
            } else {}
            break;
          case "move":
            str += "${cond.split(" ")[1]} 이동 안에 ";
            if (_isGameCleared) {
              boo = boo && _moveCount <= int.parse(cond.split(" ")[1]);
            } else {}
            break;
          case "no":
            String target = cond.split(" ")[1];
            if (target == "item") {
              str += "아이템 사용하지 않고 ";
              if (_isGameCleared) {
                boo = boo && _usedItemCountMap.values.fold(0, (p, c) => p + c) == 0;
              } else {}
            }

            List<ItemData> itemList = [ItemData.isolate, ItemData.release, ItemData.vaccine, ItemData.diagonal];
            for (ItemData item in itemList) {
              if (target == item.name) {
                str += "${item.caption} 사용하지 않고 ";
                if (_isGameCleared) {
                  boo = boo && _usedItemCountMap[item] == 0;
                } else {}
              }
            }

            break;

          case "limit":
            String target = cond.split(" ")[1];
            int num = int.parse(cond.split(" ")[2]);

            if (target == "item") {
              str += "아이템 ${num}개 이하로 사용하고 ";
              if (_isGameCleared) {
                boo = boo && _usedItemCountMap.values.fold(0, (p, c) => p + c) <= num;
              } else {}
            }

            List<ItemData> itemList = [ItemData.isolate, ItemData.release, ItemData.vaccine, ItemData.diagonal];
            for (ItemData item in itemList) {
              if (target == item.name) {
                str += "${item.caption} ${num}개 이하로 사용하고 ";
                if (_isGameCleared) {
                  boo = boo && _usedItemCountMap[item] <= num;
                } else {}
              }
            }
        }
      }

      result[str] = boo;


      strList.add(str);
    }

    print(result);
    print(_isGameCleared);


    if (currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY) {
      if (!_isGameCleared) {
        List<int> levelProcessList = getLevelProcessList();
        int originLevelStatus = levelProcessList[levelData.seq - 1];

        List<bool> havingStar = [];
        havingStar.add(originLevelStatus % 2 == 1);
        havingStar.add(originLevelStatus ~/ 2 % 2 == 1);
        havingStar.add(originLevelStatus ~/ 4 % 2 == 1);
        print(havingStar);
        print(originLevelStatus / 2);
        for (int i = 0; i < result.keys.length; i++) {
          result[result.keys.toList()[i]] = havingStar[i];
        }
      }
    }

    if (getOnlyStr == true) {
      print("sldfjlsdjfklsdkflsdklf");
      return strList;
    }

    return result;
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

  bool isConfined({TileData tile}) {
    for (TileData t in _confinedTileList) {
      if (t.x == tile.x && t.y == tile.y) {
        return true;
      }
    }
    return false;
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

      if (_highlightTileMap[HighlightTile.selectable].length == 0) {
        showCustomToast("자가격리 대상이 없습니다.", ToastType.small);
        _highlightTileMap[HighlightTile.selectable] = [];
        _selectedItem = null;
      } else {
        showCustomToast("자가격리 대상을 선택해주세요.", ToastType.small);
      }
    } else if (item == ItemData.release) {
      _highlightTileMap[HighlightTile.selectable] = _isolatedTileList;
      if (_highlightTileMap[HighlightTile.selectable].length == 0) {
        showCustomToast("자가격리 해제 대상이 없습니다.", ToastType.small);
        _highlightTileMap[HighlightTile.selectable] = [];
        _selectedItem = null;
      } else {
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
      if (_highlightTileMap[HighlightTile.selectable].length == 0) {
        showCustomToast("백신 투약 대상이 없습니다.", ToastType.small);
        _highlightTileMap[HighlightTile.selectable] = [];
        _selectedItem = null;
      } else {
        showCustomToast("백신 투약 대상을 선택해주세요.", ToastType.small);
      }
    } else if (item == ItemData.diagonal) {
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

      showCustomToast("대각선 이동 대상을 선택해주세요.", ToastType.small);
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

  void selectTile({TileData tile, SelectType selectType}) {
    if (selectType == SelectType.personSelect || selectType == SelectType.personSelectDiagonal) {
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

      bool _isTargetTileConfined = isConfined(tile: tile);
      print(_isTargetTileConfined);
      List<Direction> directionList;

      if (selectType == SelectType.personSelect) {
        directionList = [Direction.down, Direction.left, Direction.right, Direction.up];
      } else {
        directionList = [Direction(1, 1), Direction(1, -1), Direction(-1, 1), Direction(-1, -1)];
      }

      for (Direction d in directionList) {
        TileData destTile = TileData(x: tile.x + d.x, y: tile.y + d.y);

        if (isSelectableTile(tile: destTile, selectMode: SelectMode.move)) {
          Tiles tileType = Tiles.getTileType(tile: tile, levelData: _levelData);
          Tiles destTileType = Tiles.getTileType(tile: destTile, levelData: _levelData);
          if (!(tileType == Tiles.player && destTileType == Tiles.person) &&
              !(tileType == Tiles.person && destTileType == Tiles.player)) {
            if (_isTargetTileConfined && !isConfined(tile: destTile)) {
              continue;
            }

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
        if (_isDiagonalMove) {
          _isDiagonalMove = false;
        }

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

          _usedItemCountMap[ItemData.isolate] += 1;

          audioCache.play(SoundPath.isolate, mode: PlayerMode.LOW_LATENCY);
          showCustomToast("자가격리!", ToastType.normal);

          if (Tiles.getTileType(tile: tile, levelData: levelData) == Tiles.player) {
            if (!levelData.items.containsKey("release") || levelData.items["release"] == 0) {
              GamesServices.unlock(achievement: Achievement(androidID: AchievementData.isolatePlayer));
            }
          }
        } else if (selectedItem == ItemData.release) {
          _isolatedTileList.removeWhere((element) => element.x == tile.x && element.y == tile.y);
          _highlightTileMap[HighlightTile.isolated].removeWhere((element) => element.x == tile.x && element.y == tile.y);
          notifyListeners();
          if (isAroundTileFive(tile: tile)) {
            _isolatedTileList.add(tile);
            Future.delayed(const Duration(milliseconds: 350), () {
              _highlightTileMap[HighlightTile.isolated].add(tile);
              notifyListeners();
            });
          } else {
            _levelData.items[selectedItem.name] -= 1;
            _usedItemCountMap[ItemData.release] += 1;

            audioCache.play(SoundPath.release, mode: PlayerMode.LOW_LATENCY);
            showCustomToast("자가격리 해제!", ToastType.normal);
          }
        } else if (selectedItem == ItemData.vaccine) {
          _personDataList
              .removeWhere((p) => (p.x == tile.x && p.y == tile.y && p.idx == _levelData.map[tile.y][tile.x] - 1));

          _levelData.map[tile.y][tile.x] -= 1;
          _levelData.items[selectedItem.name] -= 1;
          _usedItemCountMap[ItemData.vaccine] += 1;

          audioCache.play(SoundPath.vaccine, mode: PlayerMode.LOW_LATENCY);
          showCustomToast("백신 투약!", ToastType.normal);
        } else if (selectedItem == ItemData.diagonal) {
          _selectedTile = null;
          _isDiagonalMove = true;
          selectTile(tile: tile, selectType: SelectType.personSelectDiagonal);
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

  GlobalStatus() {
    isEditMode = false;
    init();
  }

  init() async {
    // Map<String, dynamic> data = await parseJsonFromAssets('assets/json/levelData.json');
    // levelDataList = data["levels"].map<LevelData>((x) => LevelData.fromJson(x)).toList();
    Map<String, dynamic> mapJson = MapJsonClass.getMapJson();
    levelDataList = mapJson["levels"].map<LevelData>((x) => LevelData.fromJson(x)).toList();

    await loadSaveData();

    var storage = FlutterSecureStorage();

    String savedVolumeValue = await storage.read(key: "volumeValue");
    String savedIsVibrate = await storage.read(key: "isVibrate");

    if (savedVolumeValue == null) {
      _volumeValue = 1;
    } else {
      _volumeValue = double.parse(savedVolumeValue);
    }
    if (savedIsVibrate == null) {
      _isVibrate = "true";
    } else {
      _isVibrate = savedIsVibrate;
    }

    notifyListeners();
  }

  bool isDestinationAbleTile(TileData t) {
    return t.x >= 0 && t.x < _levelData.mapWidth && t.y >= 0 && t.y < _levelData.mapHeight && _levelData.map[t.y][t.x] != -1;
  }

  void initLevel() {



    _counter = Counter();

    _isDiagonalMove = false;

    _moveCount = 0;
    _isGameCleared = false;
    _usedItemCountMap = {ItemData.vaccine: 0, ItemData.release: 0, ItemData.isolate: 0, ItemData.diagonal: 0};

    _highlightTileMap = {
      HighlightTile.selected: [],
      HighlightTile.moveable: [],
      HighlightTile.five: [],
      HighlightTile.isolated: [],
      HighlightTile.confined: [],
      HighlightTile.selectable: [],
    };
    _isolatedTileList = [];

    _confinedTileList = [];

    _selectedTile = null;
    _personDataList = [];
    _selectedItem = null;
    _selectMode = SelectMode.normal;

    if (levelData.isolated != null) {
      for (int i = 0; i < levelData.mapHeight; i++) {
        for (int j = 0; j < levelData.mapWidth; j++) {
          if (levelData.isolated[i][j] != 0) {
            TileData tile = TileData(x: j, y: i);
            _isolatedTileList.add(tile);
            _highlightTileMap[HighlightTile.isolated].add(tile);
          }
        }
      }
    }
    if (levelData.confined != null) {
      for (int i = 0; i < levelData.mapHeight; i++) {
        for (int j = 0; j < levelData.mapWidth; j++) {
          if (levelData.confined[i][j] != 0) {
            TileData tile = TileData(x: j, y: i);
            _confinedTileList.add(tile);
            _highlightTileMap[HighlightTile.confined].add(tile);
          }
        }
      }
    }
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

    // audioCache.play(SoundPath.step, mode: PlayerMode.LOW_LATENCY,volume: volumeValue);
    audioCache.play(SoundPath.step, mode: PlayerMode.LOW_LATENCY);

    notifyListeners();

    if (isAroundTileFive(tile: destTile)) {
      _selectedTile = null;
      _highlightTileMap[HighlightTile.selected] = [];
      _highlightTileMap[HighlightTile.moveable] = [];

      Future.delayed(const Duration(milliseconds: 350), () {
        _personDataList = tempPersonDataList;
        _levelData = tempLevelData;
        notifyListeners();
      });
    } else {
      if (_isDiagonalMove) {
        _isDiagonalMove = false;

        _levelData.items[ItemData.diagonal.name] -= 1;

        _usedItemCountMap[ItemData.diagonal] += 1;
      }

      _moveCount += 1;

      _selectedTile = null;
      _highlightTileMap[HighlightTile.selected] = [];
      _highlightTileMap[HighlightTile.moveable] = [];

      if (isGoal()) {
        print("goal!");

        Future.delayed(const Duration(milliseconds: 350), () {
          runVibrate(duration: 1000);

          _isGameCleared = true;
          print("muyaho!");
          audioCache.play(SoundPath.clear, mode: PlayerMode.LOW_LATENCY);
          if (currentGameMode == GameMode.ORIGINAL_LEVEL_PLAY) {
            clearProcess();
          }else if(currentGameMode == GameMode.CUSTOM_LEVEL_EDITING){
            Map<String, dynamic> levelStarInfo = getLevelStarInfo();
            bool f = true;
            for(String k in levelStarInfo.keys){
              f = f & levelStarInfo[k];
            }
            if(f == true){
              testedLevelData = _tempCustomLevelData.clone();

              print(_tempCustomLevelData.toJson());

              isCustomLevelTestCompleted = true;
            }

          }

          notifyListeners();
        });

        // showGoalDialog(context);

      } else {
        Future.delayed(const Duration(milliseconds: 350), () {
          selectTile(tile: destTile, selectType: SelectType.personSelect);
        });
      }
    }
  }

  bool isGoal() {
    for (int i = 0; i < _levelData.mapHeight; i++) {
      for (int j = 0; j < _levelData.mapWidth; j++) {
        if (Tiles.getTileType(tile: TileData(x: j, y: i), levelData: levelData) == Tiles.player) {
          if (!(_goalTile.x == j && _goalTile.y == i)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  bool isFiveAll() {
    _highlightTileMap[HighlightTile.five] = [];
    notifyListeners();
    bool fiveFlag = false;
    for (int i = 0; i < _levelData.mapHeight; i++) {
      for (int j = 0; j < _levelData.mapWidth; j++) {
        TileData destTile = TileData(x: j, y: i);
        fiveFlag = fiveFlag | isTargetTileFive(destTile: destTile, isHighlight: true);
      }
    }
    return fiveFlag;
  }

  bool isTargetTileFive({TileData destTile, bool isHighlight}) {
    int cnt = 0;

    if (isSelectableTile(tile: destTile, selectMode: SelectMode.move)) {
      Tiles destTileType = Tiles.getTileType(tile: destTile, levelData: _levelData);
      if (destTileType != Tiles.person && destTileType != Tiles.player) {
        return false;
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

        _highlightTileMap[HighlightTile.five].add(destTile);
        for (Direction dd in [Direction.down, Direction.left, Direction.right, Direction.up]) {
          TileData destTile_2 = TileData(x: destTile.x + dd.x, y: destTile.y + dd.y);
          if (isSelectableTile(tile: destTile_2, selectMode: SelectMode.move)) {
            _highlightTileMap[HighlightTile.five].add(destTile_2);
          }
        }
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool isAroundTileFive({TileData tile}) {
    _highlightTileMap[HighlightTile.five] = [];
    notifyListeners();
    bool fiveFlag = false;
    for (Direction d in [Direction(0, 0), Direction.down, Direction.left, Direction.right, Direction.up]) {
      TileData destTile = TileData(x: tile.x + d.x, y: tile.y + d.y);
      fiveFlag = fiveFlag | isTargetTileFive(destTile: destTile, isHighlight: true);
    }
    if (!isEditMode) {
      Future.delayed(const Duration(milliseconds: 350), () {
        _highlightTileMap[HighlightTile.five] = [];
      });

      if (fiveFlag) {
        // audioCache.play(SoundPath.beep, mode: PlayerMode.LOW_LATENCY);
        runVibrate(duration: 500);
        showCustomToast("5인 이상 집합 금지!", ToastType.normal);

        _counter.increaseValue("five");
      }
    }

    return fiveFlag;
  }

  void runVibrate({int duration}) {
    if (_isVibrate == "true") {
      Vibration.vibrate(duration: duration);
    }
  }

// void runSound({Duration duration}){
//   if(_isVibrate == true){
//     Vibration.vibrate(duration: duration);
//   }
// }

}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}
