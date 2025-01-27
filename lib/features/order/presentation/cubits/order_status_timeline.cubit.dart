import 'dart:async';
import 'package:nomo_app/core/presentation/base_cubits/base.cubit.dart';
import 'package:nomo_app/core/presentation/base_cubits/base.state.dart';
import 'package:nomo_app/core/services/notification_services/notification.service.dart';
import 'package:nomo_app/features/order/data/common/enum/order_status.enum.dart';

class OrderStatusTimelineCubit extends BaseCubit<
    ({
      DeliveryStatus status,
      String? deliveryCaptainContactNum,
      String? deliveryCaptainName
    })> {
  OrderStatusTimelineCubit(
    super.context,
  );

  DeliveryStatus _status = DeliveryStatus.packingInProgress;
  String? deliveryCaptainContactNum;
  String? deliveryCaptainName;

  String? currentOrderId;

  @override
  ({
    DeliveryStatus status,
    String? deliveryCaptainContactNum,
    String? deliveryCaptainName
  }) get data => (
        status: _status,
        deliveryCaptainContactNum: deliveryCaptainContactNum,
        deliveryCaptainName: deliveryCaptainName
      );

  updateOrderStatus(
      {String? status,
      String? deliveryCaptainContactNum,
      String? deliveryCaptainName}) {
    if (status != null) {
      _status = DeliveryStatusExtension.fromString(status);
      emit(BaseCompletedState(data: data));
    }
  }

  @override
  FutureOr<void> init() async {
    // if (state is! BaseLoadingState) emit(const BaseLoadingState());
    // await _fetchSubCategories();
    _status = DeliveryStatus.packingInProgress;
    NotificationService.onOrderStatusUpdate = (
        {String? status,
        String? orderId,
        String? deliveryCaptainContactNum,
        String? deliveryCaptainName}) {
      if (currentOrderId == orderId) {
        updateOrderStatus(
            status: status,
            deliveryCaptainContactNum: deliveryCaptainContactNum,
            deliveryCaptainName: deliveryCaptainName);
      }
    };

    if (!isDisposed) {
      emit(BaseCompletedState(data: data));
    }
  }
}
