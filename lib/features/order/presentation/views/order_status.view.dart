import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/utils/tel.util.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/views/injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/dashboard/presentation/view/dashboard.view.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/data/repositories/order_impl.repository.dart';
import 'package:nomo_app/features/order/data/sources/order_impl.source.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';
import 'package:nomo_app/features/order/presentation/cubits/order_status.cubit.dart';
import 'package:nomo_app/features/order/presentation/views/order_summary.view.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_status_timeline.widget.dart';

class OrderStatusView extends StatelessWidget {
  static String routeName = "/order_status_view";
  const OrderStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments is OrderModel
        ? ModalRoute.of(context)!.settings.arguments as OrderModel
        : null;
    String? orderId = args?.id.toString();
    return InjectableBaseView<OrderStatusCubit, OrderModel?>(
      builder: (context, state) {
        return OrderStatusViewContent(
          orderModel: args ?? state.data,
        );
      },
      listener: (context, state) => print(state),
      cubitBuilder: (BuildContext context) => OrderStatusCubit(context,
          orderUsecase: OrderUsecase(
              repository: OrderImplRepository(
                  dataSource:
                      OrderImplDataSource(httpService: ApiRestService()))),
          orderId: orderId,
          order: args),
    );
  }
}

class OrderStatusViewContent extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderStatusViewContent({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        await Navigator.of(context).pushNamedAndRemoveUntil(
          DashboardView.routeName,
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
          titleWidget: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText("Order Status").db().bold(),
                  TextButton(
                      onPressed: () {
                        TelUtil.makePhoneCall("+918788004021");
                      },
                      child: CustomText("Need Help?")
                          .dm()
                          .textColor(Theme.of(context).primaryColor))
                ],
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "paperbag".png,
                    fit: BoxFit.scaleDown,
                  ),
                )),
            Expanded(
              flex: 6,
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      OrderStatusTimelineWidget(
                        currentOrderId: orderModel?.id,
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                        "${orderModel?.orderItems?.length} Items : Rs ${orderModel?.totalAmount} Total")
                                    .dm()
                                    .bold(),
                                TextButton(
                                    onPressed: () {
                                      NavigationService.goNext(
                                          context, OrderSummaryView.routeName,
                                          arg: orderModel);
                                    },
                                    child: CustomText(
                                            "Order #ID${orderModel?.id} >")
                                        .dm()
                                        .textColor(
                                            Theme.of(context).primaryColor))
                              ],
                            ),
                            const Divider(
                              thickness: 3,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                ),
                                CustomText("  Delivering To : ").dm().bold(),
                                Flexible(
                                  child: CustomText(
                                          "${orderModel?.address?.streetName1}, ${orderModel?.address?.streetName2}, ${orderModel?.address?.pincode}")
                                      .ds(),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
