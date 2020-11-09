import 'package:hive/hive.dart';

part 'calendarItem.g.dart';

@HiveType(typeId: 1)
class CalendarItem {
  CalendarItem({
    this.type,
    this.uid,
    this.name,
    this.description,
    this.categories,
    this.dtstamp,
    this.dtstart,
    this.dtend,
  });

  factory CalendarItem.fromMap(Map<String, dynamic> map) {
    CalendarItem item = CalendarItem(
      type: map['type'] as String ?? 'empty',
      uid: map['uid'] as String ?? 'empty',
      name: map['summary'] as String ?? 'empty',
      description: map['description'] as String ?? 'empty',
      categories: map['categories'] as List<String> ?? [null],
      dtstamp: map['dtstamp'] as DateTime,
      dtstart: map['dtstart'] as DateTime,
      dtend: map['dtend'] as DateTime,
    );
    return item;
  }
  @HiveField(0)
  final List<String> categories;
  @HiveField(1)
  final DateTime dtend;
  @HiveField(2)
  final DateTime dtstamp;
  @HiveField(3)
  final DateTime dtstart;
  @HiveField(4)
  final String name;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final String uid;
  @HiveField(7)
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'type': type,
      'description': description,
      'categories': categories,
      'dtStamp': dtstamp,
      'dtStart': dtstart,
      'dtEnd': dtend
    };
  }
}
