import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_bottom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/cart/presentation/widgets/bill_summary_item.widget.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_details_item.widget.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_summary_card.widget.dart';

class OrderSummaryView extends StatelessWidget {
  static String routeName = "/order_summary_view";
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBottomAppbar(
        title: "Order Summary",
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText("5 items delivered").db().bold(),
              CustomText(
                "Arrived at 5:15 PM",
              ).lm().overflow(TextOverflow.ellipsis).maxLines(1)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap:
                      true, // Allows ListView to shrink to the height of its content
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents it from scrolling separately
                  itemCount: 5, // Number of items
                  itemBuilder: (context, index) {
                    return const OrderSummaryCardWidget();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("Bill Summary").db().bold(),
                  Card(
                    color: Theme.of(context).primaryColor.withOpacity(0.33),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(children: [
                        BillSummaryItemWidget(title: "MRP Total", value: 140),
                        BillSummaryItemWidget(title: "GST (18%)", value: 0),
                        BillSummaryItemWidget(
                            title: "Items Savings", value: 40),
                        BillSummaryItemWidget(title: "Delivery Fee", value: 0),
                        SizedBox(height: 4),
                        Divider(thickness: 2),
                        SizedBox(height: 6),
                        BillSummaryItemWidget(title: "To Pay", value: 100),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("Order Details").db().bold(),
                    const SizedBox(height: 4),
                    const OrderDetailsItemWidget(
                      title: "Order id",
                      value: "ORD123456789",
                    ),
                    const OrderDetailsItemWidget(
                      title: "Payment",
                      value: "Paid Online",
                    ),
                    const OrderDetailsItemWidget(
                      title: "Deliver to",
                      value:
                          "Ishika Gupta, B-94 basant vihar colony, Indore (M.P)",
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
