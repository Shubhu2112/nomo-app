import 'package:flutter/material.dart';
import 'package:nomo_app/core/services/flavor_services/flavor_config.dart';
import 'package:nomo_app/core/services/payment_services/razorpay_service/models/razorpay_options.model.dart';
import 'package:nomo_app/core/services/payment_services/razorpay_service/razorpay_service.dart';
import 'package:nomo_app/core/services/payment_services/razorpay_service/repositories/razorpay.repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayRepositoryImpl implements RazorpayRepository {
  final RazorpayService _razorpayService;
  final Function(PaymentFailureResponse response) handlePaymentError;
  final Function(PaymentSuccessResponse response) handlePaymentSuccess;
  final Function(ExternalWalletResponse response) handleExternalWallet;
  RazorpayRepositoryImpl(BuildContext context,
      {required this.handlePaymentError,
      required this.handleExternalWallet,
      required this.handlePaymentSuccess})
      : _razorpayService = RazorpayService(context, handlePaymentError,
            handleExternalWallet, handlePaymentSuccess);

  @override
  void dispose() {
    _razorpayService.dispose();
  }

  @override
  void openCheckout(RazorPayOptionsModel razorPayOptionsModel) {
    razorPayOptionsModel = razorPayOptionsModel.copyWith(
        key: FlavorConfig.instance?.configuration['razorpayKey'],
        name: "NOMO");
    _razorpayService.openCheckout(razorPayOptionsModel);
  }

  @override
  handlePaymentSucess() {
    // TODO: implement handlePaymentSucess
    throw UnimplementedError();
  }
}
