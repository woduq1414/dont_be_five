import 'dart:io';

import 'package:hive/hive.dart';
part 'SaveData.g.dart';

@HiveType(typeId: 1)
class SaveData extends HiveObject {

  @HiveField(0)
  List<int> levelProcessList;

  @override
  String toString() {
    return levelProcessList.toString();
  }
}
