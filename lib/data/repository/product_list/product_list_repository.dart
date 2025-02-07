import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:product_listing_app/data/remote/api/product_list_api.dart';
import 'package:product_listing_app/models/request/wish_list_request/add_wish_list_request.dart';
import 'package:product_listing_app/models/response/getProductListResponse.dart';
import 'package:product_listing_app/models/response/get_banner_response.dart';
import 'package:product_listing_app/models/response/get_wish_list_response.dart';
import 'package:product_listing_app/models/response/wish_List_Add_Remove_Response.dart';

class ProductListRepository {
  final ProductListApi api;
  var logger = Logger();

  ProductListRepository({required this.api});

  Future<List<GetBannerResponse>?> getBannersApi() async {
    try {
      final response = await api.getBannersApi();

      if (response == null) {
        throw Exception("No response from the server.");
      }

      logger.i("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);


          if (jsonResponse is List) {
            return jsonResponse.map((data) => GetBannerResponse.fromJson(data)).toList();
          } else {
            throw Exception("Invalid response format: Expected a List but got a Map.");
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } else {
        final jsonResponse = response.body.isNotEmpty ? json.decode(response.body) : {};
        final message = jsonResponse['message'] as String? ?? "Error fetching banners";
        throw Exception(message);
      }
    } catch (e) {
      logger.e("Error in getBannersApi: $e");
      return null;
    }
  }

  Future<List<GetProductListResponse>?> getProductsApi() async {
    try {
      final response = await api.getProductsApi();

      if (response == null) {
        throw Exception("No response from the server.");
      }

      logger.i("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);


          if (jsonResponse is List) {
            return jsonResponse.map((data) => GetProductListResponse.fromJson(data)).toList();
          } else {
            throw Exception("Invalid response format: Expected a List but got a Map.");
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } else {
        final jsonResponse = response.body.isNotEmpty ? json.decode(response.body) : {};
        final message = jsonResponse['message'] as String? ?? "Error fetching products";
        throw Exception(message);
      }
    } catch (e) {
      logger.e("Error in getProductApi: $e");
      return null;
    }
  }

  Future<WishListAddRemoveResponse> adRemoveWishlistApi(
      AddWishListRequest request) async {
    try {
      final response = await api.adRemoveWishlistApi(request.toJson());

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return WishListAddRemoveResponse.fromJson(jsonResponse);
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

  Future<List<GetWishListResponse>?> getWishListApi() async {
    try {
      final response = await api.getWishListApi();

      if (response == null) {
        throw Exception("No response from the server.");
      }

      logger.i("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);


          if (jsonResponse is List) {
            return jsonResponse.map((data) => GetWishListResponse.fromJson(data)).toList();
          } else {
            throw Exception("Invalid response format: Expected a List but got a Map.");
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } else {
        final jsonResponse = response.body.isNotEmpty ? json.decode(response.body) : {};
        final message = jsonResponse['message'] as String? ?? "Error fetching products";
        throw Exception(message);
      }
    } catch (e) {
      logger.e("Error in getWishListApi: $e");
      return null;
    }
  }

}
