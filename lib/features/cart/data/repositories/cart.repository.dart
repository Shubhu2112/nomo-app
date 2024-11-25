import 'package:nomo_app/features/cart/data/models/cart.model.dart';

abstract class CartRepository {
  Future<CartModel?> checkout(CartModel? cart);
}