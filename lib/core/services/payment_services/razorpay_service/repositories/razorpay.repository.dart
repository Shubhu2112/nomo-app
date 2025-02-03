import 'package:nomo_app/core/services/payment_services/razorpay_service/models/razorpay_options.model.dart';

abstract class RazorpayRepository {
  void openCheckout(RazorPayOptionsModel razorPayOptionsModel);
  void dispose();
  dynamic handlePaymentSucess();
}
