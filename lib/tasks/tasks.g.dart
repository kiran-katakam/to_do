// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalTaskAdapter extends TypeAdapter<PersonalTask> {
  @override
  final int typeId = 0;

  @override
  PersonalTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalTask(
      title: fields[0] as String,
      description: fields[1] as String,
      isRelatedToMoney: fields[2] as bool,
      money: fields[3] as double?,
      dueDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.isRelatedToMoney)
      ..writeByte(3)
      ..write(obj.money)
      ..writeByte(4)
      ..write(obj.dueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AcademicTaskAdapter extends TypeAdapter<AcademicTask> {
  @override
  final int typeId = 1;

  @override
  AcademicTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AcademicTask(
      courseCode: fields[0] as String,
      description: fields[1] as String,
      dueDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AcademicTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.courseCode)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcademicTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
