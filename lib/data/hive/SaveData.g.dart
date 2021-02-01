// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SaveData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveDataAdapter extends TypeAdapter<SaveData> {
  @override
  final int typeId = 1;

  @override
  SaveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveData()..levelProcessList = (fields[0] as List)?.cast<int>();
  }

  @override
  void write(BinaryWriter writer, SaveData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.levelProcessList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
