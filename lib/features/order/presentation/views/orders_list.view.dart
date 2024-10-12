import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_list_card.widget.dart';

class OrdersListView extends StatelessWidget {
  static String routeName = "/order_List_view";
  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0)
                  const SizedBox(
                    height: kToolbarHeight +
                        100, // Adjust height to compensate for the extended app bar
                  ),
                const OrderListCardWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
