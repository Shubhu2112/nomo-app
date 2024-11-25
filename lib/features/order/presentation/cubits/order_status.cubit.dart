import 'dart:async';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/features/order/data/models/order.model.dart';
import 'package:nomo_app/features/order/domain/order.usecase.dart';

class OrderStatusCubit extends BaseCubit<OrderModel?> {
  OrderStatusCubit(super.context,
      {required this.orderUsecase, required this.orderId, this.order});

  final OrderUsecase orderUsecase;

  OrderModel? order;
  final String? orderId;

  @override
  OrderModel? get data => order;

  _fetchOrder() async {
    final result = await orderUsecase.getOrderDetails(orderId);
    order = result;

    // emit(BaseCompletedState(data: data));
  }

  @override
  FutureOr<void> init() async {
    if (state is! BaseLoadingState) emit(const BaseLoadingState());
    if (order?.address == null) {
      await _fetchOrder();
    }

    if (!isDisposed) {
      emit(BaseCompletedState(data: data));
    }
  }
}
