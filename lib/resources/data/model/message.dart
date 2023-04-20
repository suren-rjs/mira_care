import 'dart:convert';

class Message {
  Message({
    required this.dateTime,
    required this.senderId,
    this.receiverId,
    required this.channelName,
    required this.message,
    this.multiMedia,
    this.status,
    this.imageUri,
  });

  final String senderId;
  final DateTime dateTime;
  final String? receiverId;
  final String channelName;
  final String message;
  final List<String>? multiMedia;
  final String? status;
  final String? imageUri;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          json["dateTime"].seconds * 1000,
        ),
        imageUri: json["imageUri"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        channelName: json["channelName"],
        message: json["message"],
        multiMedia: json["multiMedia"] == null
            ? []
            : List<String>.from(json["multiMedia"]!.map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "senderId": senderId,
        "receiverId": receiverId,
        "channelName": channelName,
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
