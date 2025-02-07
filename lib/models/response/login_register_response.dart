// To parse this JSON data, do
//
//     final loginRegisterResponse = loginRegisterResponseFromJson(jsonString);

import 'dart:convert';

LoginRegisterResponse loginRegisterResponseFromJson(String str) => LoginRegisterResponse.fromJson(json.decode(str));

String loginRegisterResponseToJson(LoginRegisterResponse data) => json.encode(data.toJson());

class LoginRegisterResponse {
  Token token;
  String userId;
  String message;

  LoginRegisterResponse({
    required this.token,
    required this.userId,
    required this.message,
  });

  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) => LoginRegisterResponse(
    token: Token.fromJson(json["token"]),
    userId: json["user_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token.toJson(),
    "user_id": userId,
    "message": message,
  };
}

class Token {
  String access;

  Token({
    required this.access,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    access: json["access"],
  );

  Map<String, dynamic> toJson() => {
    "access": access,
  };
}
