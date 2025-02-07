// To parse this JSON data, do
//
//     final wishListAddRemoveResponse = wishListAddRemoveResponseFromJson(jsonString);

import 'dart:convert';

WishListAddRemoveResponse wishListAddRemoveResponseFromJson(String str) => WishListAddRemoveResponse.fromJson(json.decode(str));

String wishListAddRemoveResponseToJson(WishListAddRemoveResponse data) => json.encode(data.toJson());

class WishListAddRemoveResponse {
  String message;

  WishListAddRemoveResponse({
    required this.message,
  });

  factory WishListAddRemoveResponse.fromJson(Map<String, dynamic> json) => WishListAddRemoveResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
