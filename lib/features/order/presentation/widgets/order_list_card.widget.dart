import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/data/extensions/date_time.extension.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/cart/data/models/cart_item.model.dart';
import 'package:nomo_app/features/cart/presentation/cubit/cart.cubit.dart';
import 'package:nomo_app/features/cart/presentation/view/cart.view.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/presentation/views/order_summary.view.dart';

class OrderListCardWidget extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderListCardWidget({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          NavigationService.goNext(context, OrderSummaryView.routeName,
              arg: orderModel);
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
                            CustomText(
                                    "Order ${orderModel?.deliveryDetail?.deliveryStatus}")
                                .db(),
                            Row(
                              children: [
                                CustomText(
                                  orderModel?.totalAmount?.toString() ?? "",
                                  showCurrencySymbol: true,
                                ).lm(),
                                CustomText(" • ").dm(),
                                CustomText((
                                  // orderModel?.deliveryDetail
                                  //               ?.deliveryStatus ==
                                  //           "Delivered"
                                  //       ? orderModel?.deliveryDateTime ?? ""
                                  //       : 
                                        orderModel
                                                ?.deliveryDetail?.updatedTime?.toLocal()
                                                .formatDateTime() ??
                                            ""))
                                    .lm(),
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
                      itemCount: orderModel?.orderItems?.length,
                      // shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        CartItemModel? cartItem =
                            orderModel?.orderItems?[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: cartItem?.product?.image != null
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  child: Image.network(
                                    cartItem?.product?.image ?? "",
                                    fit: BoxFit.fill,
                                    height: 54,
                                    width: 54,
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  child: SvgPicture.asset(
                                    "apple".svg,
                                    fit: BoxFit.fill,
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
                  onTap: () async {
                    if (orderModel?.orderItems != null) {
                      context.read<CartCubit>().cartState?.cartItems = [];
                      await Future.forEach(orderModel!.orderItems!,
                          (element) async {
                        if (context.mounted) {
                          context.read<CartCubit>().addProductToCartWithOption(
                              element.product,
                              productOptionValue: element.productOptionValue,
                              quantity: element.quantity ?? 1);
                        }
                      });
                    }
                    if (context.mounted) {
                      NavigationService.goNext(context, CartView.routeName);
                    }
                  },
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
