import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.model.freezed.dart';
part 'address.model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  factory AddressModel({
   @JsonKey(includeIfNull: false) int? id,
    String? streetName1,
    String? streetName2,
    String? lat,
    String? long,
    String? name,
    int? pincode,
   @JsonKey(includeToJson: false)   @Default(false) bool? isSelected,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}
