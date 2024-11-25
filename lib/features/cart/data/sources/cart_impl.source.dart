import 'dart:convert';

import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/cart/data/sources/cart.source.dart';

class CartImplDataSource implements CartDataSource {
  CartImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<CartModel?> checkout(CartModel? cart) async {
    jsonEncode(cart?.toJson());
    final apiResponse = await _httpService.handlePostRequest(
      ApiConstants.cartCheckout,
      cart?.toJson(),
      isPublic: false,
    );

    CartModel? response;
    try {
      response = CartModel.fromJson(apiResponse?.data ?? {});
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
