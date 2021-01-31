import 'dart:convert';

import 'package:dont_be_five/common/path.dart';

class ItemData {
  final String name;
  final String imagePath;

  const ItemData({this.name, this.imagePath});

  static const ItemData isolate = ItemData(name: "isolate", imagePath: ImagePath.isolate);
  static const ItemData release = ItemData(name: "release", imagePath: ImagePath.release);
  static const ItemData vaccine = ItemData(name: "vaccine", imagePath: ImagePath.vaccine);

}
