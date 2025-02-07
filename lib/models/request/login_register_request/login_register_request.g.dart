// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterRequest _$LoginRegisterRequestFromJson(
        Map<String, dynamic> json) =>
    LoginRegisterRequest(
      phone_number: json['phone_number'] as String,
      first_name: json['first_name'] as String,
    );

Map<String, dynamic> _$LoginRegisterRequestToJson(
        LoginRegisterRequest instance) =>
    <String, dynamic>{
      'phone_number': instance.phone_number,
      'first_name': instance.first_name,
    };
