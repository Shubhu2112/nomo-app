import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class ProfileItemListWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Function()? onTap;
  const ProfileItemListWidget({super.key, this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                CustomText(" $title").db(),
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
