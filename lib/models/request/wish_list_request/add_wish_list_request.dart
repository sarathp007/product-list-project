
import 'package:json_annotation/json_annotation.dart';
part 'add_wish_list_request.g.dart';
@JsonSerializable()
class AddWishListRequest {
  final String product_id;

  AddWishListRequest({required this.product_id,});

  factory AddWishListRequest.fromJson(Map<String, dynamic> json) =>
      _$AddWishListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddWishListRequestToJson(this);
}
