import 'dart:convert';

class Note {
  Note({
    this.id,
    this.content,
    this.avatarImage,
    this.multiMedia,
    this.dateTime,
  });

  final String? id;
  final String? content;
  final String? avatarImage;
  final List<String>? multiMedia;
  final DateTime? dateTime;

  factory Note.fromRawJson(String str, String id) =>
      Note.fromMap(json.decode(str), id);

  String toRawJson() => json.encode(toMap());

  factory Note.fromMap(Map<String, dynamic> json, String id) => Note(
        id: id,
        content: json["content"],
        avatarImage: json["avatarImage"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            json["dateTime"].seconds * 1000),
        multiMedia: json["multiMedia"] == null
            ? []
            : List<String>.from(json["multiMedia"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "content": content,
        "avatarImage": avatarImage,
        "dateTime": dateTime,
        "multiMedia": multiMedia == null
            ? []
            : List<dynamic>.from(multiMedia!.map((x) => x)),
      };

  get contentLength => content?.length ?? 0;

  bool get isMultimediaMsg => multiMedia?.isNotEmpty ?? false;

  get contentHeightFactor =>
      ((contentLength / 40) + (contentLength / 40 < 2 ? 1.1 : 0));

  get factor => contentLength < 25
      ? 0.055
      : contentLength < 50
          ? 0.033
          : contentLength < 100
              ? 0.035
              : contentLength < 200
                  ? 0.04
                  : contentLength < 250
                      ? 0.045
                      : contentLength < 500
                          ? 0.035
                          : contentLength < 1000
                              ? 0.03
                              : contentLength < 2000
                                  ? 0.028
                                  : 0.025;
}
