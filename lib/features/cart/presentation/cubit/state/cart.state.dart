import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';

class CartState extends BaseCompletedState<List<CartItemModel>> {
  List<CartItemModel> cartItems;
  OrderModel? orderModel;
  CartState(this.cartItems, this.orderModel);
}

class OrderPlaceState extends BaseCompletedState<CartState> {
  OrderPlaceState({super.data});
}

class EmptyCartState extends BaseCompletedState<CartState> {
  String? message;
  EmptyCartState({super.data, this.message});
}
