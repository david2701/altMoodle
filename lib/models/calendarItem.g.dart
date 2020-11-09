// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendarItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarItemAdapter extends TypeAdapter<CalendarItem> {
  @override
  final int typeId = 1;

  @override
  CalendarItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarItem(
      type: fields[5] as String,
      uid: fields[6] as String,
      name: fields[4] as String,
      description: fields[7] as String,
      categories: (fields[0] as List)?.cast<String>(),
      dtstamp: fields[2] as DateTime,
      dtstart: fields[3] as DateTime,
      dtend: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.categories)
      ..writeByte(1)
      ..write(obj.dtend)
      ..writeByte(2)
      ..write(obj.dtstamp)
      ..writeByte(3)
      ..write(obj.dtstart)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.uid)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
