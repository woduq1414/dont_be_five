class Direction {
  final int x;
  final int y;

  const Direction(this.x, this.y);

  static const Direction up = Direction(0,1);
  static const Direction down = Direction(0, -1);
  static const Direction left = Direction(-1, 0);
  static const Direction right = Direction(1, 0);


  // static const Alignment topLeft = Alignment(-1.0, -1.0);

  // Direction getReversed(Direction d){
  //   return Direction(-d.x, -d.y);
  // }


}