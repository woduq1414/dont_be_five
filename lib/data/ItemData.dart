import 'dart:convert';

import 'package:dont_be_five/common/path.dart';

class ItemData {
  final String name;
  final String imagePath;
  final String caption;

  const ItemData({this.name,this.caption, this.imagePath});

  static const ItemData isolate = ItemData(name: "isolate",caption: "자가격리", imagePath: ImagePath.isolate);
  static const ItemData release = ItemData(name: "release",caption: "격리해제", imagePath: ImagePath.release);
  static const ItemData vaccine = ItemData(name: "vaccine",caption: "백신", imagePath: ImagePath.vaccine);
  static const ItemData diagonal = ItemData(name: "diagonal",caption: "대각선 이동", imagePath: ImagePath.diagonal);

  static List<ItemData> getItemDataList(){
    return [ItemData.isolate, ItemData.release, ItemData.vaccine, ItemData.diagonal];
  }


}
