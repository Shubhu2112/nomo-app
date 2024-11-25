import 'dart:convert';

import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/core/data/constant/api_constants.dart';
import 'package:nomo_app/core/services/network_services/http.service.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/data/sources/order.source.dart';

class OrderImplDataSource implements OrderDataSource {
  OrderImplDataSource({required HttpService httpService})
      : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<OrderModel?> placeOrder(CartModel? cart) async {
    jsonEncode(cart?.toJson());
    final apiResponse = await _httpService.handlePostRequest(
      ApiConstants.placeOrder,
      cart?.toJson(),
      isPublic: false,
    );

    OrderModel? response;
    try {
      response = OrderModel.fromJson(apiResponse?.data ?? {});
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<OrderModel?> getOrderDetails(String? orderId) async {
    final apiResponse = await _httpService.handleGetRequest(
      "${ApiConstants.getOrder}/$orderId",
      isPublic: false,
    );

    OrderModel? response;
    try {
      response = OrderModel.fromJson(apiResponse?.data ?? {});
    } catch (e) {
      rethrow;
    }

    return response;
  }
  
  @override
  Future<List<OrderModel>?> getOrders(Params? params) async {
   final apiResponse = await _httpService.handleGetRequestList(
      ApiConstants.getOrder,
      // params: params,
      isPublic: false,
      useDataKey: false
    );

    List<OrderModel>? response;
    try {
      response = apiResponse?.data
          ?.map(
            (e) => OrderModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }

    return response;
  }
}
