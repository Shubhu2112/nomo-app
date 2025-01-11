import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/core/presentation/views/dependency_injection/get_it_dependency_injection.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/cart/data/models/cart.model.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/domain/cart.usecase.dart';
import 'package:nomo_app/features/cart/presentation/cubit/state/cart.state.dart';
import 'package:nomo_app/features/dashboard/presentation/cubit/home.cubit.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';
import 'package:nomo_app/features/order/presentation/views/order_status.view.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';
import 'package:nomo_app/features/profile/presentation/view/profile.view.dart';

class CartCubit extends BaseCubit<CartState> {
  CartCubit(
    super.context, {
    required this.cartUsecase,
    required this.orderUsecase,
  });

  final CartUsecase cartUsecase;
  final OrderUsecase orderUsecase;

  CartState? cartState;

  // fetchProducts(String subCategoryId) async {
  //   emit(const BaseLoadingState());
  //   products = [];
  //   Params params = Params();
  //   params.andFilters
  //       .add(Filter(field: "subCategoryId", values: [subCategoryId]));
  //   params.andFilters.add(Filter(field: "enabled", values: ["true"]));
  //   final result = await productListUsecase.getProducts(params);
  //   products = result;

  //   emit(BaseCompletedState(data: data));
  // }

  @override
  CartState? get data => cartState;

  // Increment quantity for products with options
  void incrementQuantityWithOption(int? productId, {int? optionValueId}) {
    cartState?.cartItems = cartState?.cartItems.map((item) {
          if (item.productId == productId &&
              (item.productOptionValueId == optionValueId ||
                  optionValueId == null)) {
            // Increment the quantity if both productId and optionValueId match (or optionValueId is null for products without options)
            return item.copyWith(quantity: (item.quantity ?? 0) + 1);
          }
          return item;
        }).toList() ??
        [];

    print(data?.cartItems
        .map(
          (e) => e,
        )
        .toList());

    emit(BaseCompletedState(data: data));
  }

  // Decrement quantity for products with options
  void decrementQuantityWithOption(int? productId, {int? optionValueId}) {
    // First, decrement quantities or mark items for removal by setting quantity to null
    cartState?.cartItems = cartState?.cartItems
            .map((item) {
              if (item.productId == productId &&
                  (item.productOptionValueId == optionValueId ||
                      optionValueId == null)) {
                // If quantity is greater than 1, decrement the quantity
                if ((item.quantity ?? 1) > 1) {
                  return item.copyWith(quantity: (item.quantity ?? 1) - 1);
                } else {
                  // If quantity is 1, we mark it for removal by returning null
                  return null;
                }
              }
              return item;
            })
            .where(
                (item) => item != null) // Filter out items marked for removal
            .cast<CartItemModel>()
            .toList() ??
        [];

    print(data?.cartItems.map((e) => e).toList());
    emit(BaseCompletedState(data: data));
  }

  // Add product to the cart, with or without options
  void addProductToCartWithOption(ProductModel? product,
      {ProductOptionValueModel? productOptionValue, int quantity = 1}) {
    final cartItem = CartItemModel(
      productId: product?.id ?? 0,
      productOptionValueId: productOptionValue?.id,
      product: product,
      productOptionValue: productOptionValue,
      // maxRetailPrice: product?.maxRetailPrice ?? maxRetailPrice,
      // unit: product?.unit ?? optionName,
      // name: product?.name,
      // image: product?.image,
      // price: product?.sellingPrice ?? sellingPrice,
      quantity: quantity, // Default quantity is 1
      // productModel: product,
    );
    cartState?.cartItems.add(cartItem);
    print(data?.cartItems
        .map(
          (e) => e,
        )
        .toList());
    emit(BaseCompletedState(data: data));
  }

  // Update cart based on whether the product has options or not
  // void updateCartStateWithOption(ProductModel product, {int? optionValueId}) {
  //   final existingItem = cartState?.cartItems.firstWhere(
  //     (item) =>
  //         item.productId == product.id &&
  //         (item.productOptionValueId == optionValueId || optionValueId == null),
  //     orElse: () => CartItemModel(),
  //   );

  //   if (existingItem?.productId != null) {
  //     // If the product with or without option is already in the cart, increase its quantity
  //     incrementQuantityWithOption(product.id ?? 0,
  //         optionValueId: optionValueId);
  //   } else {
  //     // If the product is not in the cart, add it
  //     addProductToCartWithOption(product, optionValueId: optionValueId);
  //   }
  // }

  void removeProductFromCartWithOption(int? productId, {int? optionValueId}) {
    cartState?.cartItems.removeWhere((item) =>
        item.productId == productId &&
        (optionValueId == null || item.productOptionValueId == optionValueId));

    print(data?.cartItems.map((e) => e).toList());
    emit(BaseCompletedState(data: data));
  }

  // updateCartState(ProductModel? productModel, {int quantity = 1}) {
  //   cartState?.cartItems.add(CartItemModel(
  //       productId: productModel!.id!,
  //       price: productModel.sellingPrice,
  //       productOptionValueId:
  //           (productModel.productOptionsValues?.isNotEmpty ?? false)
  //               ? productModel.productOptionsValues?.first.id ?? 0
  //               : 0,
  //       quantity: quantity));
  //   print(cartState?.cartItems
  //       .map(
  //         (e) => e.toJson(),
  //       )
  //       .toList());
  //   emit(BaseCompletedState(data: data));
  // }

  // void updateCartItem(CartItemModel? updatedItem) {
  //   cartState?.cartItems = cartState?.cartItems.map((item) {
  //         return item.productId == updatedItem?.productId
  //             ? updatedItem ?? CartItemModel()
  //             : item;
  //       }).toList() ??
  //       [];

  //   emit(BaseCompletedState(data: data));
  // }

  checkout() async {
    isLoading = true;
    emit(const BaseLoadingState());
    if (cartState?.cartItems.isNotEmpty ?? false) {
      CartModel? cartModel = await cartUsecase.checkout(
          CartModel(storeId: 1, cartItems: cartState?.cartItems ?? []));
      cartState?.cartItems = [];
      cartState?.cartItems.addAll(cartModel?.cartItems ?? []);
      isLoading = false;
      emit(BaseCompletedState(data: data));
    } else {
      emit(EmptyCartState(data: data, message: "Your cart is empty"));
    }
  }

  placeOrder(int addressId) async {
    int storeId =  getIt<HomeCubit>().data?.$3?.id ?? 0;
    OrderModel? orderModel = await orderUsecase.placeOrder(CartModel(
        storeId: storeId,
        addressId: addressId,
        cartItems: cartState?.cartItems ?? []));
    cartState?.orderModel = orderModel;
    if (orderModel != null) {
      emit(OrderPlaceState(data: data));
    }
  }

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await fetchProducts(subCategoryId!);
    cartState = CartState([], null);
    if (!isDisposed) {
      emit(BaseCompletedState(data: data));
    }
  }
}
