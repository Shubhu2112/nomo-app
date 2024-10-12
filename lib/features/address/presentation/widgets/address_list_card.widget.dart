import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class AddressListCardWidget extends StatelessWidget {
  final String? addressName;
  final String? address;
  const AddressListCardWidget({
    super.key,
    this.address = "B-003 blue pearl, malad west, Mumbai - 400064",
    this.addressName = "Home 1",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.pin_drop,
            size: 44,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(addressName ?? "").db().bold(),
                CustomText(address ?? "").db(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
