
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/authentication/data/models/user.model.dart';
import 'package:nomo_app/features/authentication/data/repository/auth.repository.dart';

class AuthUsecase {
  final AuthRepository _repository;

  AuthUsecase({required AuthRepository repository}) : _repository = repository;


  Future<bool?> sendOtp(String? contactNum) async {
    return await _repository.sendOtp(contactNum);
  }

  Future<ApiResponse<UserModel?>?> verifyOtp(
      String? contactNum, String? otp) async {
    return await _repository.verifyOtp(contactNum, otp);
  }

  Future<UserModel?> updateName(String? contactNum, String? name) async {
    return await _repository.updateName(contactNum, name);
  }

 Future<UserModel?> getUser() async {
    return await _repository.getUser();
  }

}
