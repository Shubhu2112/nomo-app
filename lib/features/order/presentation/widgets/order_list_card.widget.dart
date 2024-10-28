import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/order/presentation/views/order_summary.view.dart';

class OrderListCardWidget extends StatelessWidget {
  const OrderListCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          NavigationService.goNext(context, OrderSummaryView.routeName);
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_box,
                          size: 42,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText("Order deilvered").db(),
                            Row(
                              children: [
                                CustomText(
                                  "200",
                                  showCurrencySymbol: true,
                                ).lm(),
                                CustomText("•").dm(),
                                CustomText(
                                  "21 Aug, 5:15 PM",
                                ).lm(),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 32,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      // shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 8,
                            child: SvgPicture.asset(
                              "apple".svg ?? "",
                              width: 68,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        );

                        // Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: Container(
                        //     width: 100,
                        //     decoration: const BoxDecoration(
                        //         borderRadius: BorderRadius.all(Radius.circular(22)),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               blurRadius: 2,
                        //               offset: Offset(0, 3),
                        //               blurStyle: BlurStyle.outer)
                        //         ]),
                        //     padding: const EdgeInsets.all(8),
                        //     // backgroundColor: Theme.of(context).colorScheme.onSurface,
                        //     child: SvgPicture.asset("apple".svg ?? ""),
                        //   ),
                        // );
                      }),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 4,
                        height: 2,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText("Reorder")
                          .db()
                          .textColor(Theme.of(context).primaryColor),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
