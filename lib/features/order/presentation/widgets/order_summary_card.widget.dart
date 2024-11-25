import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';

class OrderSummaryCardWidget extends StatelessWidget {
  final CartItemModel? cartItem;
  final bool isProductCard;

  const OrderSummaryCardWidget({
    super.key,
    required this.cartItem,
    this.isProductCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 8,
              child: cartItem?.product?.image != null
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Image.network(
                        cartItem?.product?.image ?? "",
                        fit: BoxFit.fill,
                        height: 44,
                        width: 40,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: SvgPicture.asset(
                        "apple".svg,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(cartItem?.product?.name ?? "").db(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(cartItem?.product?.unit ??
                            cartItem?.productOptionValue?.name ??
                            "")
                        .lm(),
                    Row(
                      children: [
                        CustomText("₹${cartItem?.price ?? 0}").dm().bold(),
                        const SizedBox(width: 6),
                        CustomText("₹${cartItem?.maxRetailPrice ?? 0}")
                            .decoration(TextDecoration.lineThrough)
                            .fontSize(12),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
