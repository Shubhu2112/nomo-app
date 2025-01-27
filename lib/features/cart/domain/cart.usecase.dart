import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/data/repositories/cart.repository.dart';

class CartUsecase {
  final CartRepository _repository;

  CartUsecase({required CartRepository repository}) : _repository = repository;
  static ({double priceTotal, double totalSavings, double maxRetailPriceTotal})
      calculateCartTotal(List<CartItemModel> cartItems) {
    double priceTotal = 0;
    double totalSavings = 0;
    double maxRetailPriceTotal = 0;

    for (var item in cartItems) {
      final itemQuantity = item.quantity ?? 1;
      final maxRetailPrice = item.maxRetailPrice?? item.product?.maxRetailPrice ??
          item.productOptionValue?.maxRetailPrice ??
          0;
      final sellingPrice = item.price ?? item.product?.sellingPrice ??
          item.productOptionValue?.sellingPrice ??
          0;

      // Calculate total selling price for this item
      priceTotal += sellingPrice * itemQuantity;

      // Calculate total savings for this item
      totalSavings += (maxRetailPrice - sellingPrice) * itemQuantity;

      // Calculate total max retail price for this item
      maxRetailPriceTotal += maxRetailPrice * itemQuantity;
    }

    print("Total Selling Price: $priceTotal");
    print("Total Savings: $totalSavings");
    print("Total Max Retail Price: $maxRetailPriceTotal");

    return (
      priceTotal: priceTotal,
      totalSavings: totalSavings,
      maxRetailPriceTotal: maxRetailPriceTotal,
    );
  }

  Future<CartModel?> checkout(CartModel? cart) async {
    return await _repository.checkout(cart);
  }
}
