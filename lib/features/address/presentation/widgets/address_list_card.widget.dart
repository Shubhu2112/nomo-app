import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';

class AddressListCardWidget extends StatelessWidget {
  final AddressModel? addressModel;
  final Function()? onTap;
  const AddressListCardWidget({super.key, this.addressModel,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(addressModel?.name ?? "Unnamed Address")
                      .db()
                      .bold(),
                  CustomText(
                          "${addressModel?.streetName1 ?? ''}, ${addressModel?.streetName2 ?? ''}, ${addressModel?.pincode ?? ''}")
                      .db(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
