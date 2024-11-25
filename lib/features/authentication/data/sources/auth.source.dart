import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';

abstract class AuthDataSource {
  Future<bool?> sendOtp(String? contactNum);
  Future<ApiResponse<UserModel?>> verifyOtp(String? contactNum, String? otp);
  Future<UserModel?> updateName(String? contactNum, String? name);
  Future<UserModel?> updateFcmToken(String? fcmToken);
  Future<UserModel?> getUser();
}
