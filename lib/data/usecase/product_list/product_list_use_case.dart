import 'package:product_listing_app/data/repository/product_list/product_list_repository.dart';
import 'package:product_listing_app/models/request/wish_list_request/add_wish_list_request.dart';
import 'package:product_listing_app/models/response/getProductListResponse.dart';
import 'package:product_listing_app/models/response/get_banner_response.dart';
import 'package:product_listing_app/models/response/get_wish_list_response.dart';
import 'package:product_listing_app/models/response/wish_List_Add_Remove_Response.dart';

class ProductListUseCase {
  final ProductListRepository repository;

  ProductListUseCase({required this.repository});

  Future<List<GetBannerResponse>?> getBannersApi() async {
    try {
      final response = await repository.getBannersApi();
      if (response == null || response.isEmpty) {
        throw Exception("No banners available.");
      }
      return response;
    } catch (e) {
      print("Error in getBannersApi UseCase: $e");
      return null;
    }
  }

  Future<List<GetProductListResponse>?> getProductsApi() async {
    try {
      final response = await repository.getProductsApi();
      if (response == null || response.isEmpty) {
        throw Exception("No products available.");
      }
      return response;
    } catch (e) {
      print("Error in getProductsApi UseCase: $e");
      return null;
    }
  }

  Future<WishListAddRemoveResponse> adRemoveWishlistApi(AddWishListRequest request) async {
    return repository.adRemoveWishlistApi(request);
  }


  Future<List<GetWishListResponse>?> getWishListApi() async {
    try {
      final response = await repository.getWishListApi();
      if (response == null || response.isEmpty) {
        throw Exception("No wishList available.");
      }
      return response;
    } catch (e) {
      print("Error in getWishListApi UseCase: $e");
      return null;
    }
  }
}
