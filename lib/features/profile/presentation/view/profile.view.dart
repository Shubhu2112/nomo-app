import 'package:flutter/material.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/features/address/presentation/view/address_list.view.dart';
import 'package:nomo_app/features/authentication/presentation/view/otp.view.dart';
import 'package:nomo_app/features/order/presentation/views/orders_list.view.dart';
import 'package:nomo_app/features/profile/presentation/widgets/profile_list_item.widget.dart';

import '../../../../core/services/navigation_services/navigation_service.dart';

class ProfileView extends StatelessWidget {

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Image.asset(
            "profile_background".png,
            fit: BoxFit.cover,
          ),
          // const SafeArea(
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child:,
          //   ),
          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 54,
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText("Sagar Sachdev").db().bold(),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 6),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Icon(Icons.shopping_bag_outlined),
                  //           CustomText(" Orders").db(),
                  //         ],
                  //       ),
                  //       const Icon(Icons.arrow_forward_ios)
                  //     ],
                  //   ),
                  // ),
                  ProfileItemListWidget(
                    icon: Icons.shopping_bag_outlined,
                    title: "Orders",
                    onTap: () {
                      NavigationService.goNext(
                          context, OrdersListView.routeName);
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ProfileItemListWidget(
                    icon: Icons.location_pin,
                    title: "Addresses",
                    onTap: () {
                      NavigationService.goNext(
                          context, AddressListView.routeName);
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const ProfileItemListWidget(
                    icon: Icons.info_outline,
                    title: "About us",
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomPrimaryButton(
                    textValue: CustomText("log out")
                        .lb()
                        .textColor(Theme.of(context).colorScheme.surface)
                        .bold(),
                    onPress: () {
                      NavigationService.popUntilAndPush(
                          context, OtpView.routeName);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
