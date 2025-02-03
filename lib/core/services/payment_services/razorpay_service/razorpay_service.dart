import 'package:flutter/material.dart';
import 'package:nomo_app/core/services/payment_services/razorpay_service/models/razorpay_options.model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class RazorpayService {
  late Razorpay _razorpay;
  final BuildContext context;
  final Function(PaymentFailureResponse response) handlePaymentError;
  final Function(PaymentSuccessResponse response) handlePaymentSuccess;
  final Function(ExternalWalletResponse response) handleExternalWallet;
  RazorpayService(this.context, this.handlePaymentError,
      this.handleExternalWallet, this.handlePaymentSuccess) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  void openCheckout(RazorPayOptionsModel razorPayOptionsModel) {
    Map<String, dynamic> options = razorPayOptionsModel.toJson();
    options.addAll({
      "config": {
        "display": {
          "hide": [
            {"method": 'paylater'},
            {"method": 'emi'}
          ]
        }
      },
      "theme": {"color": "#003399"}
    });
    _razorpay.open(options);
  }
}
