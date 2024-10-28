import 'package:flutter/material.dart';

import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Container(
        height: 44, // Adjust the height as necessary
        width: double.infinity, // Adjust the width as necessary
        decoration: BoxDecoration(
       color: Color(0xffF4E2E4),
          // gradient: const LinearGradient(
          //   colors: [
          //     Color(0xFFFB9DA5),
          //     Color(0xFFCB1927), // Reduced opacity
          //     Color(0xFFCB1927), // Middle color with opacity
          //     // End color with opacity
          //   ],
          //   stops: [0.87, 0.42, 0.11], // As per the design
          //   begin: Alignment(0.0, -1.0),
          //   end: Alignment(1.0, 0.0),
          //   transform: GradientRotation(0.7853982),
          // ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Subtle shadow effect
              offset: const Offset(0, 4),
              blurRadius: 16.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("Hurray !  ").lm().textColor(Theme.of(context).colorScheme.primary),
            CustomText(
              "you saved ₹26 !!!",
              
            ).lm().textColor(Theme.of(context).colorScheme.primary).bold()
          ],
        ),
      ),
    );
  }
}
