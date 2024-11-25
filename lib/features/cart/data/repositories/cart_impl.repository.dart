import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/cart/data/repositories/cart.repository.dart';
import 'package:nomo_app/features/cart/data/sources/cart.source.dart';

class CartImplRepository implements CartRepository {
  CartImplRepository({required CartDataSource dataSource})
      : _dataSource = dataSource;

  final CartDataSource _dataSource;

  @override
  Future<CartModel?> checkout(CartModel? cart) async {
    try {
      CartModel? cartModel =
          await _dataSource.checkout(cart);

      return cartModel;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
