import 'package:nomo_app/core/services/cookie_services/cookie.service.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/authentication/data/sources/auth.source.dart';

class AuthImplDataSource implements AuthDataSource {
  AuthImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<bool?> sendOtp(String? contactNum) async {
    final apiResponse = await _httpService.handlePostRequest(
      ApiConstants.sendOtp,
      {"contactNum": contactNum},
      isPublic: true,
    );

    bool? response;
    try {
      response = (apiResponse?.statusCode ?? 404) == 200;
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<UserModel?> updateName(String? contactNum, String? name) async {
    final apiResponse = await _httpService.handlePostRequest(
      ApiConstants.updateUserName,
      {"contactNum": contactNum, "name": name},
      isPublic: false,
    );

    UserModel? response;
    try {
      response = UserModel.fromJson(apiResponse?.data ?? {});
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<ApiResponse<UserModel?>> verifyOtp(
      String? contactNum, String? otp) async {
    final apiResponse = await _httpService.handlePostRequest(
      ApiConstants.verifyOtp,
      {"contactNum": contactNum, "otp": otp},
      isPublic: true,
    );

    ApiResponse<UserModel?> response;

    try {
      response = ApiResponse<UserModel?>();
      response.data = (apiResponse?.statusCode ?? 404) == 200
          ? UserModel.fromJson(apiResponse?.data ?? {})
          : null;
      response.statusCode = apiResponse?.statusCode;
      response.message = apiResponse?.message;
      response.accessToken = apiResponse?.accessToken;

      await CookieService.storeData(key: "token", value: response.accessToken);
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<UserModel?> getUser() async {
    final apiResponse = await _httpService.handleGetRequest(
      ApiConstants.getUser,
      isPublic: false,
    );

    UserModel? response;
    try {
      response = UserModel.fromJson(apiResponse?.data ?? {});
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
