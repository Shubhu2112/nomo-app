import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_option.model.freezed.dart';
part 'product_option.model.g.dart';

@freezed
class ProductOptionModel with _$ProductOptionModel {
  factory ProductOptionModel({
    int? id,
    bool? enabled,
    String? name,
    String? image,
    int? priority,
    int? productsId,
    DateTime? createdTime,
    DateTime? updatedTime,
  }) = _ProductOptionModel;

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);
}
