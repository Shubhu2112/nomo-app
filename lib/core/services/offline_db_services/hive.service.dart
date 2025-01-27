
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String cartBoxName = 'cartBox';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemModelAdapter());
    await Hive.openBox<CartItemModel>(cartBoxName);
  }

  Box<CartItemModel> getCartBox() {
    return Hive.box<CartItemModel>(cartBoxName);
  }

  Future<void> addCartItem(CartItemModel item) async {
    final box = getCartBox();
    await box.put(item.productId, item);
  }

  Future<void> updateCartItem(CartItemModel item) async {
    final box = getCartBox();
    await box.put(item.productId, item);
  }

  Future<void> removeCartItem(int productId) async {
    final box = getCartBox();
    await box.delete(productId);
  }

  List<CartItemModel> getAllCartItems() {
    final box = getCartBox();
    return box.values.toList();
  }

  Future<void> clearCart() async {
    final box = getCartBox();
    await box.clear();
  }
}
