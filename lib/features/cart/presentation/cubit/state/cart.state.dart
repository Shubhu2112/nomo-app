import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';

class CartState extends BaseCompletedState<List<CartItemModel>> {
  List<CartItemModel> cartItems;
  CartState(this.cartItems);
}
