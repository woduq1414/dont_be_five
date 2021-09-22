import 'dart:convert';

class LevelData {
  int seq;
  int mapWidth;
  int mapHeight;
  List<dynamic> map;
  List<dynamic> isolated;
  List<dynamic> confined;
  Map<String, dynamic> items;
  List<String> pStarCondition;
  String rule;

  LevelData({this.seq, this.mapWidth, this.mapHeight, this.map, this.isolated, this.confined, this.items, this.pStarCondition, this.rule});

  factory LevelData.fromJson(Map<String, dynamic> json) {
    return LevelData(
      seq: json['seq'] as int,
      mapWidth: json['mapWidth'] as int,
      mapHeight: json['mapHeight'] as int,
      map: json['map'] as List<dynamic>,
      isolated: json.containsKey("isolated") ? json['isolated'] as List<dynamic> : null,
      confined: json.containsKey("confined") ? json['confined'] as List<dynamic> : null,
      items: json.containsKey("items") ? json["items"] : {},
      pStarCondition: List<String>.from(json['pStarCondition']) ,
      rule : json.containsKey("rule") ? json["rule"] : "limit5"
    );
  }

  Map<String, dynamic> toJson() => {'seq': seq, 'mapWidth': mapWidth, 'mapHeight': mapHeight, 'map': map, 'isolated' : isolated,'confined' : confined, 'items' : items, 'pStarCondition' : pStarCondition, "rule" : rule};

  LevelData clone() {
    final jsonResponse = json.decode(json.encode(this));
    return LevelData.fromJson(jsonResponse as Map<String, dynamic>);
  }
}
