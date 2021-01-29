class LevelData {
  int seq;
  int mapWidth;
  int mapHeight;
  List<dynamic> map;

  LevelData({this.seq, this.mapWidth, this.mapHeight, this.map});

  factory LevelData.fromJson(Map<String, dynamic> json) {
    return LevelData(
      seq: json['seq'] as int,
      mapWidth: json['mapWidth'] as int,
      mapHeight: json['mapHeight'] as int,
      map: json['map'] as  List<dynamic>,
    );
  }
}