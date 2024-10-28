import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/authentication/data/repository/auth.repository.dart';
import 'package:nomo_app/features/authentication/data/sources/auth.source.dart';

class AuthImplRepository implements AuthRepository {
  AuthImplRepository({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  final AuthDataSource _dataSource;

  @override
  Future<bool?> sendOtp(String? contactNum) async {
    try {
      bool? isSuccess = await _dataSource.sendOtp(contactNum);

      return isSuccess;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  @override
  Future<UserModel?> updateName(String? contactNum, String? name) async {
    try {
      UserModel? userModel = await _dataSource.updateName(contactNum, name);

      return userModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  @override
  Future<ApiResponse<UserModel?>?> verifyOtp(
      String? contactNum, String? otp) async {
    try {
      ApiResponse<UserModel?>? apiResponseUserModel =
          await _dataSource.verifyOtp(contactNum, otp);

      return apiResponseUserModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      UserModel? userModel = await _dataSource.getUser();

      return userModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
