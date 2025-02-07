
import 'package:json_annotation/json_annotation.dart';
part 'login_register_request.g.dart';
@JsonSerializable()
class LoginRegisterRequest {
  final String phone_number;
  final String first_name;

  LoginRegisterRequest({required this.phone_number,required this.first_name,});

  factory LoginRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRegisterRequestToJson(this);
}
