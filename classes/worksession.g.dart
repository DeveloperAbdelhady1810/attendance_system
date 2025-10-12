// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worksession.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkSessionAdapter extends TypeAdapter<WorkSession> {
  @override
  final int typeId = 2;

  @override
  WorkSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkSession(
      session: fields[0] as Session,
    );
  }

  @override
  void write(BinaryWriter writer, WorkSession obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.session);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
