// data/auth_repository.dart

import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:product_listing_app/data/remote/api/auth_api.dart';
import 'package:product_listing_app/models/request/enter_phone_number_request/enter_phone_number_request.dart';
import 'package:product_listing_app/models/request/login_register_request/login_register_request.dart';
import 'package:product_listing_app/models/response/enter_phone_number_response.dart';
import 'package:product_listing_app/models/response/login_register_response.dart';
import 'package:product_listing_app/models/response/profile_info_response.dart';


class AuthRepository {
  final AuthApi api;

  AuthRepository({required this.api});

  var logger = Logger();

  Future<EnterPhoneNumberResponse> enterPhoneNumberApi(
      EnterPhoneNumberRequest request) async {
    try {
      final response = await api.enterPhoneNumberApi(request.toJson());

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) { // ✅ Check if response body is not empty
          final jsonResponse = json.decode(response.body);

          if (jsonResponse is Map<String, dynamic>) { // ✅ Ensure correct type
            return EnterPhoneNumberResponse.fromJson(jsonResponse);
          } else {
            throw Exception("Invalid response format from server.");
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } else {
        logger.e('Error Response Body: ${response.body}');

        String errorMessage = "An unexpected error occurred.";

        if (response.statusCode == 503 || response.statusCode == 500) {
          final jsonResponse = jsonDecode(response.body);
          errorMessage = jsonResponse['error'] as String? ?? "Server not responding";
        } else {
          try {
            final jsonResponse = jsonDecode(response.body);
            errorMessage = jsonResponse['message'] as String? ?? "Invalid phone number";
          } catch (e) {
            logger.e('Failed to decode error message: $e');
            errorMessage = "Invalid phone number";
          }
        }

        throw Exception(errorMessage);
      }
    } catch (e) {
      logger.e('Exception during API call: $e');
      throw Exception(
          "Failed to connect to the server. Please check your internet connection.");
    }
  }


  Future<LoginRegisterResponse> loginRegisterApi(
      LoginRegisterRequest request) async {
    try {
      final response = await api.loginRegisterApi(request.toJson());

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return LoginRegisterResponse.fromJson(jsonResponse);
      } else {
        logger.e('Error Response Body: ${response.body}'); // Log the error body

        // Handle specific error codes and provide meaningful messages
        String errorMessage = "An unexpected error occurred."; // Default message

        if (response.statusCode == 503 || response.statusCode == 500) {
          final jsonResponse = json.decode(response.body);
          errorMessage =
              jsonResponse['error'] as String? ?? "Server not responding";
        } else {
          try {
            final jsonResponse = json.decode(response.body);
            errorMessage =
                jsonResponse['message'] as String? ?? "Invalid phone number";
          } catch (e) {
            logger.e('Failed to decode error message: $e');
            errorMessage = "Invalid phone number"; // Provide a fallback message
          }
        }


        throw Exception(
            errorMessage);
      }
    } catch (e) {
      logger.e('Exception during API call: $e');
      throw Exception(
          "Failed to connect to the server. Please check your internet connection.");
    }
  }

  Future<ProfileInfoResponse> getProfileInfoApi() async {
    try {
      final response = await api.getProfileInfoApi();

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);

          if (jsonResponse is Map<String, dynamic>) {
            return ProfileInfoResponse.fromJson(jsonResponse);
          } else {
            throw Exception("Invalid response format from server.");
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } else {
        final jsonResponse = response.body.isNotEmpty ? json.decode(response.body) : {};
        final message = jsonResponse['message'] as String? ?? "Invalid username or password";

        throw Exception(message);
      }
    } catch (e) {
      throw Exception("Failed to fetch profile info: $e");
    }
  }

}
