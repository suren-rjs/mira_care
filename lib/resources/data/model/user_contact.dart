import 'dart:convert';

class UserContact {
  UserContact({
    required this.name,
    this.relation = 'Care Giver',
    required this.contact,
    this.imageUri,
  });

  final String name;
  final String? relation;
  final String contact;
  final String? imageUri;

  factory UserContact.fromRawJson(String str) => UserContact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserContact.fromJson(Map<String, dynamic> json) => UserContact(
        name: json["name"],
        relation: json["relation"],
        contact: json["contact"],
        imageUri: json["imageUri"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relation": relation,
        "contact": contact,
        "imageUri": imageUri,
      };
}
