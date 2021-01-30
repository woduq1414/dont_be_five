import 'dart:convert';

class PersonData {
  int x;
  int y;
  int idx;
  int count;

  String hash;

  bool isPlayer;




  factory PersonData.fromJson(Map<String, dynamic> json) {
    return PersonData(
      x: json['x'] as int,
      y: json['y'] as int,
      idx: json['idx'] as int,
      count: json['count'] as int,
      hash: json["hash"] as String,
      isPlayer : json["isPlayer"] as bool,
    );
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'idx': idx, 'count' : count, 'hash' : hash, 'isPlayer' : isPlayer};

  PersonData clone() {
    final jsonResponse = json.decode(json.encode(this));
    return PersonData.fromJson(jsonResponse as Map<String, dynamic>);
  }

  PersonData({this.x, this.y, this.idx, this.count, this.hash, this.isPlayer});
}