import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class BillSummaryItemWidget extends StatelessWidget {
  final String? title;
  final double? value;
  const BillSummaryItemWidget({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(title ?? "").db(),
        CustomText(
          value?.toString() ?? "0",
          showCurrencySymbol: true,
        ).db().left(),
      ],
    );
  }
}
