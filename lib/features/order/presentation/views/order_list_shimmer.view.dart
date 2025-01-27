import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';

class OrderListShimmerView extends StatelessWidget {
  const OrderListShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        // showBackButton: true,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      NavigationService.goBack(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )),
                CustomText("Your Orders").db().bold(),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(4.0),
              child: CommonShimmerContainer(
                child: Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 210,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
