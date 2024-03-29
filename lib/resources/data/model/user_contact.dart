import 'dart:convert';
import 'dart:typed_data';

class UserContact {
  UserContact({
    required this.name,
    this.jobTitle = 'Caregivers',
    required this.contact,
    this.imageUri,
    this.image,
  });

  final String name;
  final String? jobTitle;
  final String contact;
  final String? imageUri;
  final Uint8List? image;

  factory UserContact.fromRawJson(String str) =>
      UserContact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserContact.fromJson(Map<String, dynamic> json) => UserContact(
        name: json["name"],
        jobTitle: json["jobTitle"],
        contact: json["contact"],
        imageUri: json["imageUri"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "jobTitle": jobTitle,
        "contact": contact,
        "imageUri": imageUri,
        "image": image,
      };
}
