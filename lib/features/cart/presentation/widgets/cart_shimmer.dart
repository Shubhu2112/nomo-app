import 'package:flutter/material.dart';
import 'package:nomo_app/core/common/widget/common_shimmer_container.widget.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_bottom_appbar.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomBottomAppbar(
        title: "Your Cart",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              CommonShimmerContainer(
                height: 50,
                width: 130,
              ),
              SizedBox(
                height: 16,
              ),
              CommonShimmerContainer(
                height: 40,
                width: 130,
              ),
              SizedBox(
                height: 16,
              ),
              CommonShimmerContainer(
                height: 110,
                width: double.infinity,
              ),
              SizedBox(
                height: 16,
              ),
              CommonShimmerContainer(
                height: 50,
                width: double.infinity,
              ),
              SizedBox(
                height: 16,
              ),
              CommonShimmerContainer(
                height: 225,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
