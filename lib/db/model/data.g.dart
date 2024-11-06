// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentDataAdapter extends TypeAdapter<StudentData> {
  @override
  final int typeId = 1;

  @override
  StudentData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentData(
      name: fields[0] as String,
      age: fields[1] as String,
      place: fields[2] as String,
      admisstionNo: fields[3] as String,
      id: fields[4] as int?,
      imagePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.place)
      ..writeByte(3)
      ..write(obj.admisstionNo)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
