import 'dart:convert';

import 'package:dont_be_five/common/path.dart';

class MapInstance {
  final String name;
  final String type;
  final String imagePath;

  const MapInstance({this.name, this.type, this.imagePath});

  static const MapInstance blankTile = MapInstance(name: "빈 타일", type: "tile", imagePath: ImagePath.blank_tile);
  static const MapInstance blockTile = MapInstance(name: "기본 타일", type: "tile", imagePath: ImagePath.block_tile);
  static const MapInstance isolatedTile = MapInstance(name: "자가격리 타일", type: "tile", imagePath: ImagePath.isolated_tile);
  static const MapInstance confinedTile = MapInstance(name: "외출금지 타일", type: "tile", imagePath: ImagePath.confined_tile);

  static const MapInstance eraserObject = MapInstance(name: "지우개", type: "object", imagePath: ImagePath.eraser);
  static const MapInstance playerObject = MapInstance(name: "플레이어", type: "object", imagePath: ImagePath.player);
  static const MapInstance personObject = MapInstance(name: "사람", type: "object", imagePath: ImagePath.person);
  static const MapInstance goalObject = MapInstance(name: "목적지", type: "object", imagePath: ImagePath.goal);
}
