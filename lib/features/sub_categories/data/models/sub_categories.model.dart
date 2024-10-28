import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_categories.model.freezed.dart';
part 'sub_categories.model.g.dart';

@freezed
class SubCategoryModel with _$SubCategoryModel {
  factory SubCategoryModel({
     int? id,
     int? categoryId, // Reference to CategoryModel
    @Default(true) bool? enabled,
    String? name,
    String? image,
    int? priority,
    String? createdTime,
    String? updatedTime,
    @Default(false) bool? isSelected,
  }) = _SubCategoryModel;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
}
