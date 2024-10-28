import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories.model.freezed.dart';
part 'categories.model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    required int id,
    @Default(true) bool? enabled,
     String? name,
     String? image,
     int? priority,
     String? createdTime,
     String? updatedTime,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
