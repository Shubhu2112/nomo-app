import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
     String? id,
     String? contactNum,
     String? name,
     String? fcmToken,
     CartModel? cart,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}