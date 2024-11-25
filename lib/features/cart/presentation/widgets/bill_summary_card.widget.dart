import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/cart/presentation/widgets/bill_summary_item.widget.dart';

class BillSummaryCardWidget extends StatelessWidget {
  final double? maxRetailPriceTotal;
  final double? totalSavings;
  final double? total;
  final double? tax;
  final double? deliveryFee;
  final bool isOrderDetails;

  const BillSummaryCardWidget(
      {super.key,
      this.isOrderDetails = false,
      this.maxRetailPriceTotal,
      this.tax,
      this.total,
      this.totalSavings,
      this.deliveryFee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CustomText("Bill ${isOrderDetails ? "Details" : "Summary"}")
              .db()
              .bold(),
        ),
        Card(
          elevation: 6,
          color: const Color(0xffF4E2E4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              BillSummaryItemWidget(
                  title: "MRP Total", value: maxRetailPriceTotal),
              BillSummaryItemWidget(title: "GST (18%)", value: tax),
              BillSummaryItemWidget(
                  title: "Items Savings", value: totalSavings),
              BillSummaryItemWidget(title: "Delivery Fee", value: deliveryFee),
              const SizedBox(height: 4),
              const Divider(thickness: 2),
              const SizedBox(height: 6),
              BillSummaryItemWidget(
                  title: isOrderDetails ? "Bill Total" : "To Pay",
                  value: total),
            ]),
          ),
        ),
      ],
    );
  }
}
