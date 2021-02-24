class GameMode {
  final String mode;

  const GameMode(this.mode);

  static const GameMode ORIGINAL_LEVEL_PLAY = GameMode("originalLevelPlay");
  static const GameMode CUSTOM_LEVEL_EDITING = GameMode("customLevelEditing");
  static const GameMode CUSTOM_LEVEL_PLAY = GameMode("customLevelPlay");



}