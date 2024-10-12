import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class OrderSuccessWidget extends StatelessWidget {
  const OrderSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Lottie.asset("success".anm, fit: BoxFit.cover, height: 248),
            CustomText("Your Order \nplaced Successfully").hb().center(),
            const SizedBox(
              height: 10,
            ),
            CustomText(
                    "Your items has been placcd and is on \nit’s way to being processed")
                .ls()
                .center(),
          ],
        ),
      ),
    );
  }
}
