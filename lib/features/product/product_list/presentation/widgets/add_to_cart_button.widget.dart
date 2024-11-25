import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.view.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.widget.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/cart/presentation/cubit/state/cart.state.dart';
import 'package:nomo_app/features/product/product_details/presentation/widgets/product_options_bottom_sheet.widget.dart';
import 'package:nomo_app/features/product/product_list/data/models/product.model.dart';
import 'package:nomo_app/features/product/product_list/data/models/product_option_value.model.dart';
import 'package:nomo_app/features/product/product_list/presentation/widgets/quantity_selector_button.widget.dart';

class AddToCartButtonWidget extends StatelessWidget {
  final ProductModel? productModel;
  final ProductOptionValueModel? productOptionValueModel;
  final bool isDetails;
  final double? quantitySelectorHeight;

  const AddToCartButtonWidget(
      {super.key,
      this.productModel,
      this.productOptionValueModel,
      this.quantitySelectorHeight = 32,
      this.isDetails = false});

  @override
  Widget build(BuildContext context) {
    return NonInjectableBaseWidget<CartCubit, CartState>(

      builder: (context, state) {
        final cartItems = context
                .read<CartCubit>()
                .cartState
                ?.cartItems
                .where((item) => item.productId == productModel?.id) ??
            [];
        print(cartItems
                .map(
                  (e) => e.toJson(),
                )
                .toList()
                .toString() +
            "------------------ cart items");
        // Calculate total quantity for this product (sum of all options)
        final totalQuantity =
            cartItems.fold<int>(0, (sum, item) => sum + (item.quantity ?? 0));
        print(totalQuantity.toString() + "------------------ total quantity");
        // Find the cart item based on productId, and optionally, optionValueId if present
        CartItemModel? cartItem =
            (context.read<CartCubit>().cartState?.cartItems ?? []).firstWhere(
          (element) =>
              element.productId == productModel?.id &&
              (productOptionValueModel == null ||
                  element.productOptionValueId == productOptionValueModel?.id),
          orElse: () => CartItemModel(),
        );
        print(cartItem.toJson().toString() + "------------------ cart item");
        return cartItem.productId == null
            ? CustomPrimaryButton(
                textValue: CustomText("ADD")
                    .ls()
                    .textColor(Theme.of(context).colorScheme.onSurface)
                    .fontWeight(FontWeight.w900),
                width: isDetails ? 122 : 68,
                height: 32,
                radius: 8,
                padding: EdgeInsets.zero,
                onPress: () {
                  // Add to cart functionality based on whether optionValue is present
                  if (productOptionValueModel != null) {
                    context.read<CartCubit>().addProductToCartWithOption(
                        productModel,
                        productOptionValue: productOptionValueModel);
                  } else {
                    if (productModel?.productOptions?.isNotEmpty ?? false) {
                      ProductOptionsBottomSheet.bottomSheetMenu(
                        context,
                        product: productModel,
                      );
                    } else {
                      context
                          .read<CartCubit>()
                          .addProductToCartWithOption(productModel);
                    }
                  }
                },
              )
            : InkWell(
                onTap: ((productModel?.productOptions?.isNotEmpty ?? false) &&
                        productOptionValueModel == null)
                    ? () {
                        ProductOptionsBottomSheet.bottomSheetMenu(
                          context,
                          product: productModel,
                        );
                      }
                    : null,
                child: QuantitySelector(
                  isDetails: isDetails,
                  height: quantitySelectorHeight,
                  quantity:
                      ((productModel?.productOptions?.isNotEmpty ?? false) &&
                              productOptionValueModel == null)
                          ? totalQuantity
                          : cartItem.quantity ?? 1,
                  onIncrement: () {
                    if ((productModel?.productOptions?.isNotEmpty ?? false) &&
                        productOptionValueModel == null) {
                      // Open options menu if product has options but no previous option is selected
                      ProductOptionsBottomSheet.bottomSheetMenu(
                        context,
                        product: productModel,
                      );
                    } else {
                      // Directly increment if product option is selected or no options are available
                      context.read<CartCubit>().incrementQuantityWithOption(
                          productModel?.id,
                          optionValueId: productOptionValueModel?.id);
                    }
                  },
                  onDecrement: () {
                    if ((productModel?.productOptions?.isNotEmpty ?? false) &&
                        productOptionValueModel == null) {
                      // Open options menu if product has options but no previous option is selected
                      ProductOptionsBottomSheet.bottomSheetMenu(
                        context,
                        product: productModel,
                      );
                    } else {
                      // Directly decrement if product option is selected or no options are available
                      context.read<CartCubit>().decrementQuantityWithOption(
                          productModel?.id,
                          optionValueId: productOptionValueModel?.id);
                    }
                  },
                ),
              );
      },
      errorBuilder: (context, state) {
        return Text("eeoe");
      },
      listener: (context, state) => print(state),
    );
  }
}





// class AddToCartButtonWidget extends StatefulWidget {
//   final CartItemModel? cartItem;
//   final ProductModel? productModel;
//   const AddToCartButtonWidget({super.key, this.cartItem, this.productModel});

//   @override
//   State<AddToCartButtonWidget> createState() => _AddToCartButtonWidgetState();
// }

// class _AddToCartButtonWidgetState extends State<AddToCartButtonWidget> {
//   CartItemModel? cartItem;
//   @override
//   void initState() {
//     cartItem = widget.cartItem;
//     super.initState();
//   }

//   // void _incrementQuantity() {
//   //   setState(() {
//   //     if (widget.productModel?.productOptions?.isNotEmpty ?? false) {
//   //       ProductOptionsBottomSheet.bottomSheetMenu(context,
//   //           product: widget.productModel);
//   //     } else {
//   //       final updatedItem =
//   //           cartItem?.copyWith(quantity: (cartItem?.quantity ?? 0) + 1);
//   //       context.read<CartCubit>().updateCartItem(updatedItem);
//   //     }
//   //   });
//   // }

//   // void _decrementQuantity() {
//   //   setState(() {
//   //     if (widget.productModel?.productOptions?.isNotEmpty ?? false) {
//   //       ProductOptionsBottomSheet.bottomSheetMenu(context,
//   //           product: widget.productModel);
//   //     } else {
//   //       if ((cartItem?.quantity ?? 1) > 1) {
//   //         final updatedItem =
//   //             cartItem?.copyWith(quantity: (cartItem?.quantity ?? 1) - 1);
//   //         context.read<CartCubit>().updateCartItem(updatedItem);
//   //       }
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
   