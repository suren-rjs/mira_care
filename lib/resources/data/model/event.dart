import 'dart:convert';

class JournalEvent {
  JournalEvent({
    this.id,
    this.message,
    this.dateTime,
    this.category,
  });

  final String? id;
  final String? message;
  final DateTime? dateTime;
  final String? category;

  factory JournalEvent.fromRawJson(String str, String id) =>
      JournalEvent.fromJson(json.decode(str), id);

  String toRawJson() => json.encode(toJson());

  factory JournalEvent.fromJson(Map<String, dynamic> json, String id) => JournalEvent(
        id: id,
        message: json["message"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          json["dateTime"].seconds * 1000,
        ),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "dateTime": dateTime,
        "category": category,
      };
}
