// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 1;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      id: fields[0] as int,
      balance: fields[15] as String,
      cardId: fields[1] as String,
      email: fields[5] as String,
      firstName: fields[2] as String,
      gender: fields[10] as String,
      lastName: fields[3] as String,
      parrentEmail: fields[7] as String,
      parrentPassword: fields[8] as String,
      parrentPhone: fields[9] as String,
      password: fields[6] as String,
      phone: fields[4] as String,
      stage: fields[11] as String,
      place: fields[12] as String,
      state: fields[14] as String,
      time: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardId)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.parrentEmail)
      ..writeByte(8)
      ..write(obj.parrentPassword)
      ..writeByte(9)
      ..write(obj.parrentPhone)
      ..writeByte(10)
      ..write(obj.gender)
      ..writeByte(11)
      ..write(obj.stage)
      ..writeByte(12)
      ..write(obj.place)
      ..writeByte(13)
      ..write(obj.time)
      ..writeByte(14)
      ..write(obj.state)
      ..writeByte(15)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
