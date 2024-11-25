import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/date_time.extension.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_bottom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/presentation/widgets/bill_summary_card.widget.dart';
import 'package:nomo_app/features/cart/presentation/widgets/bill_summary_item.widget.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_details_item.widget.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_summary_card.widget.dart';

class OrderSummaryView extends StatelessWidget {
  static String routeName = "/order_summary_view";
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderModel = ModalRoute.of(context)!.settings.arguments is OrderModel
        ? ModalRoute.of(context)!.settings.arguments as OrderModel
        : null;
    return Scaffold(
      appBar: CustomBottomAppbar(
        title: "Order Summary",
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                      "${orderModel?.orderItems?.length} items ${orderModel?.deliveryDetail?.deliveryStatus}")
                  .db()
                  .bold(),
              CustomText(
                "${orderModel?.deliveryDetail?.deliveryStatus} at  ${orderModel?.deliveryDetail?.updatedTime?.toLocal().formatDateTime() ?? ""}",
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
                  itemCount: orderModel?.orderItems?.length, // Number of items
                  itemBuilder: (context, index) {
                    CartItemModel? orderItem = orderModel?.orderItems?[index];
                    return OrderSummaryCardWidget(
                      cartItem: orderItem,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: BillSummaryCardWidget(
                maxRetailPriceTotal: orderModel?.totalMRP,
                totalSavings: orderModel?.savings,
                total: orderModel?.totalAmount,
                isOrderDetails: true,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("Order Details").db().bold(),
                    const SizedBox(height: 4),
                    OrderDetailsItemWidget(
                      title: "Order id",
                      value: "ORD${orderModel?.id}",
                    ),
                    const OrderDetailsItemWidget(
                      title: "Payment",
                      value: "Paid Online",
                    ),
                    OrderDetailsItemWidget(
                      title: "Deliver to",
                      value:
                          "${orderModel?.address?.name}, ${orderModel?.address?.streetName1}, ${orderModel?.address?.streetName2}",
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
