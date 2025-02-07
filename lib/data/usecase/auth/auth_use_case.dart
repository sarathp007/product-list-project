


import 'package:product_listing_app/data/repository/auth/auth_repository.dart';
import 'package:product_listing_app/models/request/enter_phone_number_request/enter_phone_number_request.dart';
import 'package:product_listing_app/models/request/login_register_request/login_register_request.dart';
import 'package:product_listing_app/models/response/enter_phone_number_response.dart';
import 'package:product_listing_app/models/response/login_register_response.dart';
import 'package:product_listing_app/models/response/profile_info_response.dart';

class AuthUseCase {
  final AuthRepository repository;
  AuthUseCase({required this.repository});

  Future<EnterPhoneNumberResponse> enterPhoneNumberApi(EnterPhoneNumberRequest request) async {
    return repository.enterPhoneNumberApi(request);
  }

  Future<LoginRegisterResponse> loginRegisterApi(LoginRegisterRequest request) async {
    return repository.loginRegisterApi(request);
  }

  Future<ProfileInfoResponse> getProfileInfoApi() async {
    return repository.getProfileInfoApi();
  }
}
