import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nomo_app/core/data/extensions/assets.extensions.dart';
import 'package:nomo_app/core/presentation/dialogs/common_dialogs.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';
import 'package:nomo_app/features/address/presentation/cubit/add_address.cubit.dart';

class AddAddressBottomSheet {
  static void show(BuildContext context, Function() addressCallback) {
    showModalBottomSheet(
      context: context,
      // constraints: const BoxConstraints(maxHeight: 480),

      isScrollControlled: true, // If you want the bottom sheet to be scrollable
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for the keyboard
        ),
          child: SizedBox(
            height: 380,
            child: AddAddressForm(
              addressCallback: addressCallback,
            ),
          ),
        );
      },
    );
  }
}

class AddAddressForm extends StatelessWidget {
  final Function()? addressCallback;
  AddAddressForm({super.key, this.addressCallback});
  final List<String> addressTypes = ["Home", "Work", "Hotel", "Other"];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode address1FocusNode = FocusNode();
  final FocusNode address2FocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    AddAddressCubit cubit = context.read<AddAddressCubit>();
    String? addressType = context.watch<AddAddressCubit>().addressType;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText("Add more address details").db(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: "Flat / House no / Building name*",
            focusNode: address1FocusNode,
            isRequired: true,
            // onPress: () {
            //   address1FocusNode.nextFocus();
            // },
      
            onChanged: (value) {
               cubit.address = cubit.address?.copyWith(streetName1: value);
            },
            onSave: (value) {
              cubit.address = cubit.address?.copyWith(streetName1: value);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextField(
            hintText: "Area/Sector/ Locality*",
            focusNode: address2FocusNode,
            isRequired: true,
             onChanged: (value) {
               cubit.address = cubit.address?.copyWith(streetName2: value);
             },
            onSave: (value) {
              cubit.address = cubit.address?.copyWith(streetName2: value);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText("Save address as *").ls(),
          const SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      cubit.updateAddressType(addressTypes[index]);
                    },
                    child: Chip(
                        color: addressType == addressTypes[index]
                            ? WidgetStateProperty.all(
                                Theme.of(context).primaryColor)
                            : WidgetStateProperty.all(
                                Theme.of(context).colorScheme.surface),
                        labelPadding: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        visualDensity: VisualDensity.comfortable,
                        label: CustomText(addressTypes[index]).dm().textColor(
                            addressType == addressTypes[index]
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).primaryColor)),
                  ),
                );
              },
              itemCount: 4,
            ),
          ),
          if (addressType == "Other")
            const SizedBox(
              height: 12,
            ),
          if (addressType == "Other")
            CustomTextField(
              hintText: "Enter your own label*",
              isRequired: true,
              onChanged: (value) {
                cubit.address = cubit.address?.copyWith(name: value);
                print(cubit.address?.toJson());
              },
              onSave: (value) {
                cubit.address = cubit.address?.copyWith(name: value);
                print(cubit.address?.toJson());
              },
            ),
          const SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomPrimaryButton(
              width: double.infinity,
              textValue: CustomText("Save Address")
                  .lb()
                  .textColor(Theme.of(context).colorScheme.surface),
              onPress: () async {
                // bool isVaild = _formKey.currentState?.validate() ?? false;
                // if (isVaild && (cubit.address?.name != null)) {
                  _formKey.currentState?.save();
                  Navigator.pop(context);
                  DialogBox.loadingDialog(
                    context,
                    Lottie.asset("groceries_loading".anm,
                        fit: BoxFit.scaleDown, height: 100)
                  );
                  await cubit.addAddress();
                  cubit.addressType = null;
                  addressCallback?.call();
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
