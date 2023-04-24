import 'dart:convert';

class AuthUser {
  AuthUser({
    this.id,
    this.uid,
    this.name,
    this.userType,
    this.phone,
    this.email,
    this.avatarImage,
    this.careGiverIdList,
    this.careTakerIdList,
    this.communityChannelId,
    this.timeZone,
    this.gender,
    this.address,
    this.qualification,
    this.age,
  });

  final String? id;
  final String? uid;
  final String? name;
  final String? userType;
  final String? phone;
  final String? email;
  final String? avatarImage;
  final List<String>? careGiverIdList;
  final List<String>? careTakerIdList;
  final String? communityChannelId;
  final String? timeZone;
  final String? gender;
  final String? address;
  final String? qualification;
  final String? age;

  factory AuthUser.fromRawJson(String str, String id) =>
      AuthUser.fromJson(json.decode(str), id);

  String toRawJson() => json.encode(toJson());

  factory AuthUser.fromJson(Map<String, dynamic> json, String id) => AuthUser(
        id: id,
        uid: json["uid"],
        name: json["name"],
        userType: json["userType"],
        phone: json["phone"],
        email: json["email"],
        avatarImage: json["avatarImage"],
        careGiverIdList: json["careGiverIdList"] == null
            ? []
            : List<String>.from(json["careGiverIdList"]!.map((x) => x)),
        careTakerIdList: json["careTakerIdList"] == null
            ? []
            : List<String>.from(json["careTakerIdList"]!.map((x) => x)),
        communityChannelId: json["communityChannelId"],
        timeZone: json["timeZone"],
        gender: json["gender"],
        address: json["address"],
        qualification: json["qualification"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "userType": userType,
        "phone": phone,
        "email": email,
        "avatarImage": avatarImage,
        "careGiverIdList": careGiverIdList == null
            ? []
            : List<dynamic>.from(careGiverIdList!.map((x) => x)),
        "careTakerIdList": careTakerIdList == null
            ? []
            : List<dynamic>.from(careTakerIdList!.map((x) => x)),
        "communityChannelId": communityChannelId,
        "timeZone": timeZone,
        "gender": gender,
        "address": address,
        "qualification": qualification,
        "age": age,
      };
}
