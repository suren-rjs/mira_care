import 'dart:convert';

class CalendarRemainder {
  CalendarRemainder({
    this.id,
    this.message,
    this.dateTime,
    this.category,
    this.remainderDate,
  });

  final String? id;
  final String? message;
  final DateTime? dateTime;
  final DateTime? remainderDate;
  final String? category;

  factory CalendarRemainder.fromRawJson(String str, String id) =>
      CalendarRemainder.fromJson(json.decode(str), id);

  String toRawJson() => json.encode(toJson());

  factory CalendarRemainder.fromJson(Map<String, dynamic> json, String id) =>
      CalendarRemainder(
        id: id,
        message: json["message"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          json["dateTime"].seconds * 1000,
        ),
        remainderDate: DateTime.fromMillisecondsSinceEpoch(
          json["remainderDate"].seconds * 1000,
        ),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "dateTime": dateTime,
        "remainderDate": remainderDate,
        "category": category,
      };
}
