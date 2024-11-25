import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/data/repositories/order.repository.dart';

class OrderUsecase {
  final OrderRepository _repository;

  OrderUsecase({required OrderRepository repository})
      : _repository = repository;

  Future<OrderModel?> placeOrder(CartModel? cart) async {
    return await _repository.placeOrder(cart);
  }

  Future<OrderModel?> getOrderDetails(String? orderId) async {
    return await _repository.getOrderDetails(orderId);
  }

   Future<List<OrderModel>?> getOrders(Params params) async {
    return await _repository.getOrders(params);
  }
}
