import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/address/presentation/view/add_address.view.dart';
import 'package:nomo_app/features/address/presentation/widgets/address_list_card.widget.dart';
import 'package:nomo_app/features/address/presentation/widgets/add_address_bottomsheet.widget.dart';

class AddressListView extends StatelessWidget {
  static String routeName = "/address_List_view";
  const AddressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showBackButton: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomPrimaryButton(
          textValue: CustomText("Add New Address")
              .textColor(Theme.of(context).colorScheme.surface),
          onPress: () {
            NavigationService.goNext(context, AddAddressView.routeName);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.separated(
          itemCount: 12,
          itemBuilder: (context, index) {
            return const AddressListCardWidget();
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
