// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 3;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      sessionId: fields[2] as String,
      weekday: fields[5] as String,
      stage: fields[7] as String,
      branch: fields[6] as String,
      attendants: (fields[0] as List).cast<dynamic>(),
      name: fields[1] as String,
      mark: (fields[3] as Map).cast<String, String>(),
      time: fields[4] as String,
      isscientific: fields[8] as String,
      chpname: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.attendants)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sessionId)
      ..writeByte(3)
      ..write(obj.mark)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.weekday)
      ..writeByte(6)
      ..write(obj.branch)
      ..writeByte(7)
      ..write(obj.stage)
      ..writeByte(8)
      ..write(obj.isscientific)
      ..writeByte(9)
      ..write(obj.chpname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
