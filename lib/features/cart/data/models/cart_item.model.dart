import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.model.freezed.dart';
part 'cart_item.model.g.dart';

@freezed
class CartItemModel with _$CartItemModel {
  factory CartItemModel({
    @JsonKey(includeIfNull: false) int? id,
    int? productId,
    int? productOptionValueId,
    int? quantity,
    double? price,
    @JsonKey(includeToJson: false) double? maxRetailPrice,
    @JsonKey(includeToJson: false) String? image,
    @JsonKey(includeToJson: false) String? name,
    @JsonKey(includeToJson: false) String? unit,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}
