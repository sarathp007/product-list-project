
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app/data/cache/Cache_manager.dart';


class AuthApi {
  final String baseUrl;
  final http.Client client;

  AuthApi({required this.baseUrl, required this.client});

  //https://admin.kushinirestaurant.com/api/verify/
  Future<http.Response> enterPhoneNumberApi(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/verify/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }

  //https://admin.kushinirestaurant.com/api/login-register/
  Future<http.Response> loginRegisterApi(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/login-register/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }

  //https://admin.kushinirestaurant.com/api/user-data/
  Future<http.Response>getProfileInfoApi()async {
    final Uri uri = Uri.parse('$baseUrl/api/user-data/');
    debugPrint("..........uri $uri");

    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CacheManager.getToken()}'
      },
    );
    debugPrint(".........response of ProfileInfoApi ${response.body}  ${response.statusCode}");
    return response;

  }


}
