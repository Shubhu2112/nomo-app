import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/order/data/models/delivery_detail.model.dart';

part 'order.model.freezed.dart';
part 'order.model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    @JsonKey(includeToJson: false) int? id,
    AddressModel? address,
    @JsonKey(includeToJson: false) double? totalAmount,
    @JsonKey(includeToJson: false) double? totalMRP,
    @JsonKey(includeToJson: false) double? savings,
    @JsonKey(includeToJson: false) DateTime? createdTime,
    @JsonKey(includeToJson: false) DateTime? updatedTime,
    @JsonKey(includeToJson: false) String? deliveryDateTime,
    @JsonKey(includeToJson: false) DeliveryDetailModel? deliveryDetail,
    List<CartItemModel>? orderItems,
    @Default(false) isLoading
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
