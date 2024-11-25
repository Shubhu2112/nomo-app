import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item.model.dart';

part 'cart.model.freezed.dart';
part 'cart.model.g.dart';

@freezed
class CartModel with _$CartModel {
  factory CartModel({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(includeToJson: false) bool? enabled,
    @JsonKey(includeToJson: false) String? userId,
    int? storeId,
    @JsonKey(includeIfNull: false) int? addressId,
    @JsonKey(includeToJson: false) double? totalAmount,
    @JsonKey(includeToJson: false) double? savings,
    @JsonKey(includeToJson: false) DateTime? createdTime,
    @JsonKey(includeToJson: false) DateTime? updatedTime,
    List<CartItemModel>? cartItems,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
