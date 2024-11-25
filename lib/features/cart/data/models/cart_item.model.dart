import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';

part 'cart_item.model.freezed.dart';
part 'cart_item.model.g.dart';

@freezed
class CartItemModel with _$CartItemModel {
  factory CartItemModel({
    @JsonKey(includeIfNull: false) int? id,
    int? productId,
    @JsonKey(includeIfNull: false) int? productOptionValueId,
    int? quantity,
    @JsonKey(includeToJson: false) double? price,
    @JsonKey(includeToJson: false) ProductModel? product,
    @JsonKey(includeToJson: false) ProductOptionValueModel? productOptionValue,
    @JsonKey(includeToJson: false) double? maxRetailPrice,
    // @JsonKey(includeToJson: false) String? image,
    // @JsonKey(includeToJson: false) String? name,
    // @JsonKey(includeToJson: false) String? unit,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}
