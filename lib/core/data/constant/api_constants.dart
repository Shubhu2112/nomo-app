import 'package:dio/dio.dart';
import 'package:nomo_app/core/data/enums/api_type.enum.dart';
import 'package:nomo_app/core/services/flavor_services/flavor_config.dart';

class ApiConstants {
  ApiType? type;
  late final BaseOptions networkOptions;

  ApiConstants(this.type) {
    networkOptions = BaseOptions(
      baseUrl: getBaseUrl(type),
      responseType: ResponseType.json,
      connectTimeout: const Duration(milliseconds: 10000),
    );
  }

  String getBaseUrl(ApiType? apiType) {
    switch (apiType) {
      case ApiType.qc:
        return FlavorConfig.instance!.configuration['qcApiBaseUrl'];

      default:
        return FlavorConfig.instance!.configuration['baseUrl'];
    }
  }

  static const String appConfig = '/config';

  static const String sendOtp = "/otp/send";
  static const String verifyOtp = "/auth/verify-otp";
  static const String updateUserName = "/auth/update-name";
  static const String updateFcmToken = "/auth/update-fcm-token";
  static const String getUser = "/auth/me";
  static const String addresses = "/address";

  static const String categories = '/category';
  static const String subCategories = '/sub-category';
  static const String products = '/products';
  static const String metalPrice = '/products/rates';
  static const String storeNearby = '/stores/nearby';

  static const String cartCheckout = '/cart/cart-checkout';
  static const String placeOrder = '/order/place-order';
  static const String getOrder = '/order';
}
