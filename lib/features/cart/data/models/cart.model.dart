import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item.model.dart';

part 'cart.model.freezed.dart';
part 'cart.model.g.dart';

@freezed
class CartModel with _$CartModel {
  factory CartModel({
    int? id,
    bool? enabled,
    String? userId,
    double? totalAmount,
    double? savings,
    DateTime? createdTime,
    DateTime? updatedTime,
    List<CartItemModel>? cartItems,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
