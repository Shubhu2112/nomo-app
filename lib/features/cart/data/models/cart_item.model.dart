import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';

part 'cart_item.model.freezed.dart';
part 'cart_item.model.g.dart';

@freezed
class CartItemModel with _$CartItemModel {
  @HiveType(typeId: 0, adapterName: 'CartItemModelAdapter')
  factory CartItemModel({
    @JsonKey(includeIfNull: false) int? id,
    @HiveField(0) int? productId,
    @HiveField(1) @JsonKey(includeIfNull: false) int? productOptionValueId,
    @HiveField(2) int? quantity,
    @HiveField(3) @JsonKey(includeToJson: false) double? price,
    @JsonKey(includeToJson: false) ProductModel? product,
    @JsonKey(includeToJson: false) ProductOptionValueModel? productOptionValue,
    @HiveField(4) @JsonKey(includeToJson: false) double? maxRetailPrice,
    // @JsonKey(includeToJson: false) String? image,
    // @JsonKey(includeToJson: false) String? name,
    // @JsonKey(includeToJson: false) String? unit,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}
