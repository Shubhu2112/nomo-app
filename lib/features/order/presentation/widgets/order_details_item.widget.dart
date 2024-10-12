import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class OrderDetailsItemWidget extends StatelessWidget {
  final String? title;
  final String? value;
  const OrderDetailsItemWidget({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title ?? "").lb(),
        CustomText(value ?? "").db(),
      ],
    );
  }
}
