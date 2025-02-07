class EnterPhoneNumberResponse {
  String otp;
  Token? token; // ✅ Token can be null
  bool user;

  EnterPhoneNumberResponse({
    required this.otp,
    this.token, // ✅ Handle nullable token
    required this.user,
  });

  factory EnterPhoneNumberResponse.fromJson(Map<String, dynamic> json) => EnterPhoneNumberResponse(
    otp: json["otp"] ?? "", // ✅ Provide a default value
    token: json["token"] != null ? Token.fromJson(json["token"]) : null, // ✅ Prevent null issue
    user: json["user"] ?? false, // ✅ Provide a default value
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "token": token?.toJson(), // ✅ Prevent null serialization
    "user": user,
  };
}

class Token {
  String? access; // ✅ Access token can be null

  Token({this.access});

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    access: json["access"] ?? "", // ✅ Provide a default value if null
  );

  Map<String, dynamic> toJson() => {
    "access": access,
  };
}
