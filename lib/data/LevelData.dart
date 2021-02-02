import 'dart:convert';

class LevelData {
  int seq;
  int mapWidth;
  int mapHeight;
  List<dynamic> map;
  Map<String, dynamic> items;
  List<String> pStarCondition;

  LevelData({this.seq, this.mapWidth, this.mapHeight, this.map, this.items, this.pStarCondition});

  factory LevelData.fromJson(Map<String, dynamic> json) {
    return LevelData(
      seq: json['seq'] as int,
      mapWidth: json['mapWidth'] as int,
      mapHeight: json['mapHeight'] as int,
      map: json['map'] as List<dynamic>,
      items: json.containsKey("items") ? json["items"] : {},
      pStarCondition: List<String>.from(json['pStarCondition']) ,
    );
  }

  Map<String, dynamic> toJson() => {'seq': seq, 'mapWidth': mapWidth, 'mapHeight': mapHeight, 'map': map, 'items' : items, 'pStarCondition' : pStarCondition};

  LevelData clone() {
    final jsonResponse = json.decode(json.encode(this));
    return LevelData.fromJson(jsonResponse as Map<String, dynamic>);
  }
}
