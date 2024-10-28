import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class ProductPriceWidget extends StatelessWidget {
  final double? sellingPrice;
  final double? maxRetailPrice;
  const ProductPriceWidget({super.key, this.maxRetailPrice, this.sellingPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          "${sellingPrice ?? 0}",
          showCurrencySymbol: true,
        ).dm().bold(),
        const SizedBox(
          width: 6,
        ),
        CustomText(
          "${maxRetailPrice ?? 0}",
          showCurrencySymbol: true,
        ).decoration(TextDecoration.lineThrough).fontSize(12),
      ],
    );
  }
}
