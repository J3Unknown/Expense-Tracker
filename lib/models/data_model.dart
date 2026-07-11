import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class Track extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String note;

  @HiveField(6)
  final int year;

  @HiveField(7)
  final int month;

  @HiveField(8)
  final int week;

  @HiveField(9)
  final int day;

  @HiveField(10)
  final int hour;

  @HiveField(11)
  final int minute;

  Track({
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
    required this.note,
    required this.year,
    required this.month,
    required this.week,
    required this.day,
    required this.hour,
    required this.minute,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'type': type,
      'date': date,
      'category': category,
      'note': note,
      'year': year,
      'month': month,
      'week': week,
      'day': day,
      'hour': hour,
      'minute': minute,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      title: map['title'],
      amount: map['amount'],
      type: map['type'],
      date: map['date'],
      category: map['category'],
      note: map['note'],
      year: map['year'],
      month: map['month'],
      week: map['week'],
      day: map['day'],
      hour: map['hour'],
      minute: map['minute'],
    );
  }
}