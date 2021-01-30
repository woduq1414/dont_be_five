class TileData {
  int x;
  int y;

  factory TileData.fromJson(Map<String, dynamic> json) {
    return TileData(
      x: json['x'] as int,
      y: json['y'] as int,

    );
  }

  TileData({this.x, this.y});
}