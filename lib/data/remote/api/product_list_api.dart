
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing_app/data/cache/Cache_manager.dart';


class ProductListApi {
  final String baseUrl;
  final http.Client client;

  ProductListApi({required this.baseUrl, required this.client});


  //https://admin.kushinirestaurant.com/api/banners/
  Future<http.Response>getBannersApi()async {
    final Uri uri = Uri.parse('$baseUrl/api/banners/');
    debugPrint("..........uri $uri");

    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json',
        //'Authorization': 'Bearer ${CacheManager.getToken()}'
      },
    );
    debugPrint(".........response of ProfileInfoApi ${response.body}  ${response.statusCode}");
    return response;

  }


  // https://admin.kushinirestaurant.com/api/products/
  Future<http.Response>getProductsApi()async {
    final Uri uri = Uri.parse('$baseUrl/api/products/');
    debugPrint("..........uri $uri");

    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json',
        //'Authorization': 'Bearer ${CacheManager.getToken()}'
      },
    );
    debugPrint(".........response of ProductsApi ${response.body}  ${response.statusCode}");
    return response;

  }

  //https://admin.kushinirestaurant.com/api/add-remove-wishlist/

  Future<http.Response> adRemoveWishlistApi(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/add-remove-wishlist/'),
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CacheManager.getToken()}'
      },
      body: json.encode(data),
    );
    debugPrint(".........response of adRemoveWishlistApi ${response.body}  ${response.statusCode}");
    return response;
  }

  // https://admin.kushinirestaurant.com/api/wishlist/

  Future<http.Response>getWishListApi()async {
    final Uri uri = Uri.parse('$baseUrl/api/wishlist/');
    debugPrint("..........uri $uri");

    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer ${CacheManager.getToken()}'
      },
    );
    debugPrint(".........response of getWishListApi ${response.body}  ${response.statusCode}");
    return response;

  }

}
