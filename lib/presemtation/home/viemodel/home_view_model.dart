import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:product_listing_app/data/usecase/product_list/product_list_use_case.dart';
import 'package:product_listing_app/models/request/wish_list_request/add_wish_list_request.dart';
import 'package:product_listing_app/models/response/getProductListResponse.dart';
import 'package:product_listing_app/models/response/get_banner_response.dart';
import 'package:product_listing_app/models/response/get_wish_list_response.dart';
import 'package:product_listing_app/models/response/wish_List_Add_Remove_Response.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductListUseCase useCase;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool isBannerLoading = false;
  bool isProductLoading = false;
  bool isWishListLoading = false;
  bool isAddRemoveWishListLoading = false;
  List<GetBannerResponse>? banners;
  List<GetProductListResponse>? products;
  List<GetWishListResponse>? wishLists;
  WishListAddRemoveResponse? wishListAddRemoveResponse;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  var logger = Logger();

  HomeViewModel({required this.useCase});

  Future<void> getBanners() async {
    isBannerLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await useCase.getBannersApi();

      if (result != null) {
        banners = result;
        logger.i('Banners Fetched: ${jsonEncode(banners!.map((e) => e.toJson()).toList())}');
      } else {
        throw Exception("Failed to fetch banners.");
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again later.';
      logger.e('Exception: $e');
    } finally {
      isBannerLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProducts() async {
    isProductLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await useCase.getProductsApi();

      if (result != null) {
        products = result;
        logger.i('products Fetched: ${jsonEncode(products!.map((e) => e.toJson()).toList())}');
      } else {
        throw Exception("Failed to fetch products.");
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again later.';
      logger.e('Exception: $e');
    } finally {
      isProductLoading = false;
      notifyListeners();
    }
  }

  Future<void> adRemoveWishlistApi(String productId) async {
    isAddRemoveWishListLoading = true;
    notifyListeners();
    try {
      final request = AddWishListRequest(
          product_id: productId);
      logger.i("request${jsonEncode(request)}");
      final result = await useCase.adRemoveWishlistApi(request);
      if (kDebugMode) {
        print(request);
        print(result);
      }
      if (result.message.isNotEmpty) {
        wishListAddRemoveResponse = result;
        logger.e("wishListAddRemoveResponse200${jsonEncode(wishListAddRemoveResponse)}");


        isAddRemoveWishListLoading = false;
        notifyListeners();
      } else {
        wishListAddRemoveResponse = result;
        logger.e("loginResponse400${jsonEncode(wishListAddRemoveResponse)}");
        wishListAddRemoveResponse = null;
        isAddRemoveWishListLoading = false;
        notifyListeners();
      }
      isAddRemoveWishListLoading = false;
      notifyListeners();
    } catch (e) {


      isAddRemoveWishListLoading = false;
      if (kDebugMode) {
        print(e);
      }

      _errorMessage = "anErrorOccur";
      notifyListeners();
    }
  }

  Future<void> getWishLists() async {
    isWishListLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await useCase.getWishListApi();

      if (result != null && result.isNotEmpty) {
        wishLists = result;
        logger.i('wishLists Fetched: ${jsonEncode(wishLists!.map((e) => e.toJson()).toList())}');
      } else {
        wishLists = []; // Ensure it's an empty list instead of null
        _errorMessage = "No items found in the wishlist.";
        logger.w('Wishlist is empty.');
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again later.';
      logger.e('Exception: $e');
    } finally {
      isWishListLoading = false;
      notifyListeners();
    }
  }

}
