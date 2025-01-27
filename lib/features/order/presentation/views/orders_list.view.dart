import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/views/injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/core/services/network_services/dio_http_impl.service.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/data/repositories/order_impl.repository.dart';
import 'package:nomo_app/features/order/data/sources/order_impl.source.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';
import 'package:nomo_app/features/order/presentation/cubits/order_list.cubit.dart';
import 'package:nomo_app/features/order/presentation/views/order_list_shimmer.view.dart';
import 'package:nomo_app/features/order/presentation/widgets/order_list_card.widget.dart';

class OrdersListView extends StatelessWidget {
  static String routeName = "/order_List_view";

  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InjectableBaseView<OrderListCubit, List<OrderModel>?>(
      bottomSafeArea: false,
      builder: (context, state) {
        return OrdersListViewContent(
          orderModels: state.data,
        );
      },
      loadingbuilder: (context, state) {
        return OrderListShimmerView();
      },
      listener: (context, state) => print(state),
      cubitBuilder: (BuildContext context) => OrderListCubit(
        context,
        orderUsecase: OrderUsecase(
            repository: OrderImplRepository(
                dataSource:
                    OrderImplDataSource(httpService: ApiRestService()))),
      ),
    );
  }
}

class OrdersListViewContent extends StatelessWidget {
  final List<OrderModel>? orderModels;
  const OrdersListViewContent({super.key, this.orderModels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
        child: orderModels?.isNotEmpty ?? false
            ? ListView.builder(
              controller: context.read<OrderListCubit>().scrollController,
                padding: EdgeInsets.zero,
                itemCount: orderModels?.length,
                itemBuilder: (context, index) {
                  OrderModel? orderModel = orderModels?[index];
                  return Column(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          height: kToolbarHeight +
                              100, // Adjust height to compensate for the extended app bar
                        ),
                      OrderListCardWidget(
                        orderModel: orderModel,
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: CustomText("No Orders !!!").dm(),
              ),
      ),
    );
  }
}
