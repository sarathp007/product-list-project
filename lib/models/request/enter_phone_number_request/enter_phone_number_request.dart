
import 'package:json_annotation/json_annotation.dart';
part 'enter_phone_number_request.g.dart';
@JsonSerializable()
class EnterPhoneNumberRequest {
  final String phone_number;

  EnterPhoneNumberRequest({required this.phone_number,});

  factory EnterPhoneNumberRequest.fromJson(Map<String, dynamic> json) =>
      _$EnterPhoneNumberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EnterPhoneNumberRequestToJson(this);
}
