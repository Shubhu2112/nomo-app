import 'package:freezed_annotation/freezed_annotation.dart';

part 'store.model.freezed.dart';
part 'store.model.g.dart';

@freezed
class StoreModel with _$StoreModel {
  factory StoreModel({
    required int id,
    @Default(true) bool? enabled,
    String? name,
    String? address,
    String? image,
    double? lat,
    double? long,
    String? createdTime,
    String? updatedTime,
    int? travelTimeInMins,
  }) = _StoreModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
}
