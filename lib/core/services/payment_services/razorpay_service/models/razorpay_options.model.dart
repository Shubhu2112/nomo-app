import 'package:freezed_annotation/freezed_annotation.dart';
part 'razorpay_options.model.freezed.dart';
part 'razorpay_options.model.g.dart';

@freezed
class RazorPayOptionsModel with _$RazorPayOptionsModel {
  @JsonSerializable(explicitToJson: true)
  factory RazorPayOptionsModel({
    String? key,
    @JsonKey(name: 'order_id') String? orderId,
    String? name,
    // String? description,
    // String? timeout,
    // String? currency,
    // RazorPayOptionsPrefillModel? prefill,
  }) = _RazorPayOptionsModel;

  factory RazorPayOptionsModel.fromJson(Map<String, dynamic> json) =>
      _$RazorPayOptionsModelFromJson(json);
}
