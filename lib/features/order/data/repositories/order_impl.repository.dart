import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/data/repositories/order.repository.dart';
import 'package:nomo_app/features/order/data/sources/order.source.dart';

class OrderImplRepository implements OrderRepository {
  OrderImplRepository({required OrderDataSource dataSource})
      : _dataSource = dataSource;

  final OrderDataSource _dataSource;

  @override
  Future<OrderModel?> placeOrder(CartModel? cart) async {
    try {
      OrderModel? orderModel = await _dataSource.placeOrder(cart);

      return orderModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  @override
  Future<OrderModel?> getOrderDetails(String? orderId) async {
    try {
      OrderModel? orderModel = await _dataSource.getOrderDetails(orderId);
      return orderModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  @override
  Future<List<OrderModel>?> getOrders(Params? params)  async{
    try {
      List<OrderModel>? ordersModels =
          await _dataSource.getOrders(params);

      return ordersModels;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
