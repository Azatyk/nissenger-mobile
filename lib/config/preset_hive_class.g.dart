// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset_hive_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PresetAdapter extends TypeAdapter<Preset> {
  @override
  final int typeId = 0;

  @override
  Preset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preset(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as List<String>,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
      fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Preset obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.gradeNumber)
      ..writeByte(1)
      ..write(obj.gradeLetter)
      ..writeByte(2)
      ..write(obj.gradeGroup)
      ..writeByte(3)
      ..write(obj.foreignLanguages)
      ..writeByte(4)
      ..write(obj.firstMainProfile)
      ..writeByte(5)
      ..write(obj.secondMainProfile)
      ..writeByte(6)
      ..write(obj.thirdProfile)
      ..writeByte(7)
      ..write(obj.firstProfileGroup)
      ..writeByte(8)
      ..write(obj.secondProfileGroup)
      ..writeByte(9)
      ..write(obj.thirdProfileGroup)
      ..writeByte(10)
      ..write(obj.teacherName)
      ..writeByte(11)
      ..write(obj.presetName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PresetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
