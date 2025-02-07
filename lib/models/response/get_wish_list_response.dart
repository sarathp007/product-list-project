// To parse this JSON data, do
//
//     final getWishListResponse = getWishListResponseFromJson(jsonString);

import 'dart:convert';

List<GetWishListResponse> getWishListResponseFromJson(String str) => List<GetWishListResponse>.from(json.decode(str).map((x) => GetWishListResponse.fromJson(x)));

String getWishListResponseToJson(List<GetWishListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWishListResponse {
  int? id;
  List<dynamic>? variations;
  bool? inWishlist;
  int? avgRating;
  List<String>? images;
  bool? variationExists;
  int? salePrice;
  List<Addon>? addons;
  bool? available;
  String? availableFrom;
  String? availableTo;
  String? name;
  String? description;
  String? caption;
  String? featuredImage;
  int? mrp;
  int? stock;
  bool? isActive;
  String? discount;
  DateTime? createdDate;
  String? productType;
  dynamic showingOrder;
  String? variationName;
  int? category;
  int? taxRate;

  GetWishListResponse({
     this.id,
     this.variations,
     this.inWishlist,
     this.avgRating,
     this.images,
     this.variationExists,
     this.salePrice,
     this.addons,
     this.available,
     this.availableFrom,
     this.availableTo,
     this.name,
     this.description,
     this.caption,
     this.featuredImage,
     this.mrp,
     this.stock,
     this.isActive,
     this.discount,
     this.createdDate,
     this.productType,
    required this.showingOrder,
     this.variationName,
     this.category,
     this.taxRate,
  });

  factory GetWishListResponse.fromJson(Map<String, dynamic> json) => GetWishListResponse(
    id: json["id"],
    variations: List<dynamic>.from(json["variations"].map((x) => x)),
    inWishlist: json["in_wishlist"],
    avgRating: json["avg_rating"],
    images: List<String>.from(json["images"].map((x) => x)),
    variationExists: json["variation_exists"],
    salePrice: json["sale_price"],
    addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),
    available: json["available"],
    availableFrom: json["available_from"],
    availableTo: json["available_to"],
    name: json["name"],
    description: json["description"],
    caption: json["caption"],
    featuredImage: json["featured_image"],
    mrp: json["mrp"],
    stock: json["stock"],
    isActive: json["is_active"],
    discount: json["discount"],
    createdDate: DateTime.parse(json["created_date"]),
    productType: json["product_type"],
    showingOrder: json["showing_order"],
    variationName: json["variation_name"],
    category: json["category"],
    taxRate: json["tax_rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variations": List<dynamic>.from(variations!.map((x) => x)),
    "in_wishlist": inWishlist,
    "avg_rating": avgRating,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "variation_exists": variationExists,
    "sale_price": salePrice,
    "addons": List<dynamic>.from(addons!.map((x) => x.toJson())),
    "available": available,
    "available_from": availableFrom,
    "available_to": availableTo,
    "name": name,
    "description": description,
    "caption": caption,
    "featured_image": featuredImage,
    "mrp": mrp,
    "stock": stock,
    "is_active": isActive,
    "discount": discount,
    "created_date": createdDate?.toIso8601String(),
    "product_type": productType,
    "showing_order": showingOrder,
    "variation_name": variationName,
    "category": category,
    "tax_rate": taxRate,
  };
}

class Addon {
  int? id;
  int? price;
  String? name;
  String? description;
  String? featuredImage;
  int? stock;
  bool? isActive;
  int? taxRate;

  Addon({
     this.id,
     this.price,
     this.name,
     this.description,
     this.featuredImage,
     this.stock,
     this.isActive,
     this.taxRate,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    id: json["id"],
    price: json["price"],
    name: json["name"],
    description: json["description"],
    featuredImage: json["featured_image"],
    stock: json["stock"],
    isActive: json["is_active"],
    taxRate: json["tax_rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "name": name,
    "description": description,
    "featured_image": featuredImage,
    "stock": stock,
    "is_active": isActive,
    "tax_rate": taxRate,
  };
}
