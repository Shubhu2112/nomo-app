import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class OrderSummaryCardWidget extends StatelessWidget {
  final double? maxRetailPrice;
  final double? sellingPrice;
  final String? productName;
  final String? productOptionName;
  final String? productOptionValueName;
  final String? productImg;
  final String? productDescription;
  final bool isProductCard;
  const OrderSummaryCardWidget({
    super.key,
    this.maxRetailPrice = 90,
    this.productName = "Apple",
    this.productOptionName = "Select Unit",
    this.productOptionValueName = "1Kg",
    this.sellingPrice = 42,
    this.productImg,
    this.productDescription =
        "Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.",
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
              child: SvgPicture.asset(
                "apple".svg ?? "",
                width: 68,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(productName ?? "").db(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(productOptionValueName ?? "").lm(),
                    Row(
                      children: [
                        CustomText("₹$sellingPrice").dm().bold(),
                        const SizedBox(
                          width: 6,
                        ),
                        CustomText("₹$maxRetailPrice")
                            .decoration(TextDecoration.lineThrough)
                            .fontSize(12),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
