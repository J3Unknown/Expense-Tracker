// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackAdapter extends TypeAdapter<Track> {
  @override
  final int typeId = 0;

  @override
  Track read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Track(
      title: fields[0] as String,
      amount: fields[1] as double,
      type: fields[2] as String,
      date: fields[3] as String,
      category: fields[4] as String,
      note: fields[5] as String,
      year: fields[6] as int,
      month: fields[7] as int,
      week: fields[8] as int,
      day: fields[9] as int,
      hour: fields[10] as int,
      minute: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Track obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.month)
      ..writeByte(8)
      ..write(obj.week)
      ..writeByte(9)
      ..write(obj.day)
      ..writeByte(10)
      ..write(obj.hour)
      ..writeByte(11)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
