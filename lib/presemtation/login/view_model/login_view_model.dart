import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:product_listing_app/data/cache/Cache_manager.dart';
import 'package:product_listing_app/data/usecase/auth/auth_use_case.dart';
import 'package:product_listing_app/models/request/enter_phone_number_request/enter_phone_number_request.dart';
import 'package:product_listing_app/models/request/login_register_request/login_register_request.dart';
import 'package:product_listing_app/models/response/enter_phone_number_response.dart';
import 'package:product_listing_app/models/response/login_register_response.dart';
import 'package:product_listing_app/models/response/profile_info_response.dart';



class LoginViewModel extends ChangeNotifier {
  final AuthUseCase useCase;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  String phoneNumber = '';
  String name = '';
  bool isLoading = false;
  bool isLoginRegisterLoading = false;
  bool isProfileLoading = false;
  EnterPhoneNumberResponse? loginResponse;
  LoginRegisterResponse? loginRegisterResponse;
  ProfileInfoResponse? profileInfoResponse;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  var logger = Logger();
  bool isLoadingLogOut = false;
  String? logoutStatus;
  int? logoutStatusCode;
  LoginViewModel({required this.useCase});

  void setEnterPhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setEnterName(String value) {
    name = value;
    notifyListeners();
  }

  int? loginStatus;

  Future<void> enterPhoneNumber(String phoneNo) async {
    isLoading = true;
    loginStatus = 0;
    notifyListeners();
    try {
      final request = EnterPhoneNumberRequest(
        phone_number: phoneNo,);
      logger.i("request${jsonEncode(request)}");
      final result = await useCase.enterPhoneNumberApi(request);
      if (kDebugMode) {
        print(request);
        print(result);
      }
      if (result.otp.isNotEmpty) {
        loginResponse = result;
        CacheManager.setToken(loginResponse?.token?.access ??"");
        logger.e("loginResponse200${jsonEncode(loginResponse)}");


        isLoading = false;
        notifyListeners();
      } else {
        loginResponse = result;
        logger.e("loginResponse400${jsonEncode(loginResponse)}");
        loginResponse = null;
        isLoading = false;
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {


      isLoading = false;
      if (kDebugMode) {
        print(e);
      }

      _errorMessage = "anErrorOccur";
      notifyListeners();
    }
  }


  Future<void> loginRegister(String phoneNo) async {
    isLoginRegisterLoading = true;
    loginStatus = 0;
    notifyListeners();
    try {
      final request = LoginRegisterRequest(
        phone_number: phoneNo,first_name : name);
      logger.i("request${jsonEncode(request)}");
      final result = await useCase.loginRegisterApi(request);
      if (kDebugMode) {
        print(request);
        print(result);
      }
      if (result.token.toString().isNotEmpty) {
        loginRegisterResponse = result;
        CacheManager.setToken(loginRegisterResponse?.token?.access ?? "");
        logger.e("loginResponse200${jsonEncode(loginRegisterResponse)}");


        isLoginRegisterLoading = false;
        notifyListeners();
      } else {
        loginRegisterResponse = result;
        logger.e("loginResponse400${jsonEncode(loginRegisterResponse)}");
        loginRegisterResponse = null;
        isLoginRegisterLoading = false;
        notifyListeners();
      }
      isLoginRegisterLoading = false;
      notifyListeners();
    } catch (e) {


      isLoginRegisterLoading = false;
      if (kDebugMode) {
        print(e);
      }

      _errorMessage = "anErrorOccur";
      notifyListeners();
    }
  }

  Future<void> getProfileInfoApi() async {
    print(isProfileLoading);
    isProfileLoading = true;
    notifyListeners();
    try {
      final result = await useCase.getProfileInfoApi();

      if (kDebugMode) {
        logger.i('Raw API Response: ${jsonEncode(result)}');
      }

      if (result != null) {
        profileInfoResponse = result;

        logger.i('Parsed Data: ${jsonEncode(profileInfoResponse)}');

        isProfileLoading = false;
        notifyListeners();
      } else {
     //   logger.e('Error ${result.status}: ${result.message}');
        isProfileLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isProfileLoading = false;
      _errorMessage = 'An error occurred. Please try again later.';
      logger.e('Exception: $e');
      notifyListeners();
    }
  }


}
