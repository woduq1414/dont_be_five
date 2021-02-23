import 'dart:convert';

import 'package:dont_be_five/common/path.dart';

class MapInstance {
  final String name;
  final String type;
  final String imagePath;

  const MapInstance({this.name, this.type, this.imagePath});

  static const MapInstance blankTile = MapInstance(name: "빈 타일", type: "tile", imagePath: ImagePath.isolate);
  static const MapInstance blockTile = MapInstance(name: "기본 타일", type: "tile", imagePath: ImagePath.release);
  static const MapInstance isolatedTile = MapInstance(name: "자가격리 타일", type: "tile", imagePath: ImagePath.vaccine);
  static const MapInstance confinedTile = MapInstance(name: "외출금지 타일", type: "tile", imagePath: ImagePath.diagonal);

  static const MapInstance eraserObject = MapInstance(name: "지우개", type: "object", imagePath: ImagePath.isolate);
  static const MapInstance playerObject = MapInstance(name: "플레이어", type: "object", imagePath: ImagePath.isolate);
  static const MapInstance personObject = MapInstance(name: "사람", type: "object", imagePath: ImagePath.isolate);
  static const MapInstance goalObject = MapInstance(name: "목적지", type: "object", imagePath: ImagePath.isolate);
}
