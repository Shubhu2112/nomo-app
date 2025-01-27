import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';

part 'product.model.freezed.dart';
part 'product.model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    int? id,
    String? name,
    String? image,
    int? priority,
    int? subCategoryId,
    String? description,
    String? unit,
    double? maxRetailPrice,
    double? sellingPrice,
    List<ProductOptionModel>? productOptions,
    List<ProductOptionValueModel>? productOptionsValues,
   @Default(false) bool isLoading,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
