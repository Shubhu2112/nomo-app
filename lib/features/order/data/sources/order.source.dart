import 'package:nomo_app/core/common/parser/query_helper.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';

abstract class OrderDataSource {
  Future<OrderModel?> placeOrder(CartModel? cart);
  Future<OrderModel?> getOrderDetails(String? orderId);
  Future<List<OrderModel>?> getOrders(Params? params);
}
