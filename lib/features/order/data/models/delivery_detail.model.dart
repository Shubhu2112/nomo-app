import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_detail.model.freezed.dart';
part 'delivery_detail.model.g.dart';

@freezed
class DeliveryDetailModel with _$DeliveryDetailModel {
  factory DeliveryDetailModel({
    @JsonKey(includeToJson: false) int? id,
    int? deliveryCaptainId,
    int? packingCoordinatorId,
     String? deliveryStatus,
    DateTime? estimatedDeliveryDate,
    DateTime? actualDeliveryDate,
    @JsonKey(includeToJson: false) DateTime? createdTime,
    @JsonKey(includeToJson: false) DateTime? updatedTime,
    // DeliveryCaptainModel? deliveryCaptain,
    // PackingCoordinatorModel? packingCoordinator,
  }) = _DeliveryDetailModel;

  factory DeliveryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDetailModelFromJson(json);
}
