// To parse this JSON data, do
//
//     final profileInfoResponse = profileInfoResponseFromJson(jsonString);

import 'dart:convert';

ProfileInfoResponse profileInfoResponseFromJson(String str) => ProfileInfoResponse.fromJson(json.decode(str));

String profileInfoResponseToJson(ProfileInfoResponse data) => json.encode(data.toJson());

class ProfileInfoResponse {
  String name;
  String phoneNumber;

  ProfileInfoResponse({
    required this.name,
    required this.phoneNumber,
  });

  factory ProfileInfoResponse.fromJson(Map<String, dynamic> json) => ProfileInfoResponse(
    name: json["name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone_number": phoneNumber,
  };
}
