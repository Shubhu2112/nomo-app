import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomo_app/core/presentation/views/non_injectable_base.view.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_appbar.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/services/navigation_services/navigation_service.dart';
import 'package:nomo_app/features/address/data/models/address.model.dart';
import 'package:nomo_app/features/address/presentation/cubit/address_list.cubit.dart';
import 'package:nomo_app/features/address/presentation/view/add_address.view.dart';
import 'package:nomo_app/features/address/presentation/widgets/address_list_card.widget.dart';

class AddressListView extends StatelessWidget {
  static String routeName = "/address_List_view";
  const AddressListView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCart = false;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      isCart = (ModalRoute.of(context)!.settings.arguments as Map)["isCart"];
    }

    return NonInjectableBaseView<AddressListCubit, List<AddressModel>?>(
      bottomSafeArea: false,
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
      builder: (context, state) {
        return AddressListViewContent(
          addresses: state.data,
          isCart: isCart,
        );
      },
      listener: (context, state) => print(state),
    );
  }
}

class AddressListViewContent extends StatelessWidget {
  final List<AddressModel>? addresses;
  final bool? isCart;
  const AddressListViewContent({super.key, this.addresses, this.isCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.separated(
        itemCount: addresses?.length ?? 0,
        itemBuilder: (context, index) {
          AddressModel? address = addresses?[index];
          return AddressListCardWidget(
            addressModel: address,
            onTap: (isCart ?? false)
                ? () {
                    context
                        .read<AddressListCubit>()
                        .updateSelectedAddress(address);

                    NavigationService.goBack(context);
                  }
                : null,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          thickness: 2,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
