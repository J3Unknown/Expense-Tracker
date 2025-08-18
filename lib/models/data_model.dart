class Track {
  final int id;
  final String title;
  final double amount;
  final String type;
  final String date;
  final String category;
  final String note;
  final int year;
  final int month;
  final int week;
  final int day;
  final int hour;
  final int minute;

  Track({
    required this.id,
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
      'id': id,
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
      id: map['id'],
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