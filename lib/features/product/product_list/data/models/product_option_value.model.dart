import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_option_value.model.freezed.dart';
part 'product_option_value.model.g.dart';

@freezed
class ProductOptionValueModel with _$ProductOptionValueModel {
  factory ProductOptionValueModel({
    int? id,
    bool? enabled,
    String? name,
    int? productOptionsId,
    int? productsId,
    double? maxRetailPrice,
    double? sellingPrice,
    String? image,
   @JsonKey(includeToJson: false) String? unit,
    int? priority,
    DateTime? createdTime,
    DateTime? updatedTime,
  }) = _ProductOptionValueModel;

  factory ProductOptionValueModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionValueModelFromJson(json);
}