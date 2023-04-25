import 'dart:convert';

class UserMessage {
  UserMessage({
    this.id,
    required this.dateTime,
    required this.senderId,
    this.receiverId,
    required this.channelId,
    required this.message,
    this.multiMedia,
    this.status,
    this.imageUri,
  });

  final String? id;
  final String senderId;
  final DateTime dateTime;
  final String? receiverId;
  final String channelId;
  final String message;
  final List<String>? multiMedia;
  final String? status;
  final String? imageUri;

  factory UserMessage.fromRawJson(String str, String id) =>
      UserMessage.fromJson(json.decode(str), id);

  String toRawJson() => json.encode(toJson());

  factory UserMessage.fromJson(Map<String, dynamic> json, String id) =>
      UserMessage(
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          json["dateTime"].seconds * 1000,
        ),
        imageUri: json["imageUri"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        channelId: json["channelId"],
        message: json["message"],
        multiMedia: json["multiMedia"] == null
            ? []
            : List<String>.from(json["multiMedia"]!.map((x) => x)),
        status: json["status"],
        id: id,
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "dateTime": dateTime,
        "senderId": senderId,
        "receiverId": receiverId,
        "channelId": channelId,
        "message": message,
        "multiMedia": multiMedia == null
            ? []
            : List<dynamic>.from(multiMedia!.map((x) => x)),
        "status": status,
        "imageUri": imageUri,
      };

  get contentLength => message.length;

  bool get isMultiMediaMsg => multiMedia?.isNotEmpty ?? false;

  get contentHeightFactor =>
      ((contentLength / 40) + (contentLength / 40 < 2 ? 1.25 : 0));

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
