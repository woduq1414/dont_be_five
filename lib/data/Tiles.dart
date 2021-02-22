import 'dart:ui';

import 'package:dont_be_five/data/LevelData.dart';

import 'TileData.dart';

class Tiles {

  final String type;

  const Tiles(this.type);

  static const Tiles blank = Tiles("blank");
  static const Tiles block = Tiles("block");
  static const Tiles person = Tiles("person");
  static const Tiles player = Tiles("player");
  static const Tiles goal = Tiles("goal");

  static Tiles getTileType({TileData tile, LevelData levelData}){
    int value = levelData.map[tile.y][tile.x];

    if(value == -1){
      return Tiles.blank;
    }else if(value == 0){
      return Tiles.block;
    }else if(1 <= value && value <= 9){
      return Tiles.person;
    }else if(101 <= value && value <= 109){
      return Tiles.player;
    }else if(value == 999999) {
      return Tiles.goal;
    }else{
      return null;
    }


  }

  static int getTileValue({TileData tile, LevelData levelData}){
    return levelData.map[tile.y][tile.x];
  }


  static int getTilePersonCount({TileData tile, LevelData levelData}) {
    Tiles tileType = Tiles.getTileType(tile: tile, levelData: levelData);
    if(tileType == Tiles.player){
      return Tiles.getTileValue(tile: tile, levelData: levelData) - 100;
    }else if(tileType == Tiles.person){
      return Tiles.getTileValue(tile: tile, levelData: levelData);
    }else{
      return 0;
    }
  }

  static Offset getTileCenterOffset({TileData tile, List<dynamic> tileCornerOffsetList}) {
    return Offset(
        (tileCornerOffsetList[tile.y][tile.x].dx + tileCornerOffsetList[tile.y + 1][tile.x + 1].dx) / 2,
        (tileCornerOffsetList[tile.y][tile.x].dy + tileCornerOffsetList[tile.y + 1][tile.x + 1].dy) / 2
    );
  }

}