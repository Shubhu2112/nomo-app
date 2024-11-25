import 'dart:async';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/core/services/notification_services/notification.service.dart';
import 'package:nomo_app/features/order/data/common/enum/order_status.enum.dart';

class OrderStatusTimelineCubit extends BaseCubit<DeliveryStatus> {
  OrderStatusTimelineCubit(
    super.context,
  );

  DeliveryStatus status = DeliveryStatus.packingInProgress;
  String? currentOrderId;

  @override
  DeliveryStatus get data => status;

  updateOrderStatus(String? orderStatus) {
    if (orderStatus != null) {
      status = DeliveryStatusExtension.fromString(orderStatus);
      emit(BaseCompletedState(data: data));
    }
  }

  @override
  FutureOr<void> init() async {
    // if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await _fetchSubCategories();
    NotificationService.onOrderStatusUpdate =
        ({String? orderId, String? status}) {
      if (currentOrderId == orderId) {
        updateOrderStatus(status);
      }
    };

    if (!isDisposed) {
      emit(BaseCompletedState(data: data));
    }
  }
}
