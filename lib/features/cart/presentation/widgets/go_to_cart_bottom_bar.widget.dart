import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/cart/domain/cart.usecase.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/cart/presentation/view/cart.view.dart';

class GoToCartBottomWidget extends StatelessWidget {
  const GoToCartBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().cartState;
    ({double maxRetailPriceTotal, double priceTotal, double totalSavings})  cartAmount =
        CartUsecase.calculateCartTotal(cartState?.cartItems ?? []);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                        "${cartState?.cartItems.length} Item | ₹${cartAmount.priceTotal} ")
                    .db(),
                CustomText(
                        "₹${cartAmount.totalSavings} saved, Enjoy Free delivery!")
                    .fontSize(12)
                    .textColor(Colors.green),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
            CustomPrimaryButton(
              width: 130,
              textValue: CustomText("Go to Cart")
                  .lm()
                  .textColor(Theme.of(context).colorScheme.onPrimary),
              onPress: () {
                NavigationService.goNext(context, CartView.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
