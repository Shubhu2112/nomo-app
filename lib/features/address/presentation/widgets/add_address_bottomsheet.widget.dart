import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';

class AddAddressBottomSheet {
  static void show(BuildContext context, Function() addressCallback) {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxHeight: 480),

      isScrollControlled: true, // If you want the bottom sheet to be scrollable
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddAddressForm(),
        );
      },
    );
  }
}

class AddAddressForm extends StatelessWidget {
  AddAddressForm({super.key});
  final List<String> addressType = ["Home", "Work", "Hotel", "Other"];
  @override
  Widget build(BuildContext context) {
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
          const CustomTextField(
            hintText: "Flat / House no / Building name*",
            isRequired: true,
          ),
          const SizedBox(
            height: 12,
          ),
          const CustomTextField(
            hintText: "Area/Sector/ Locality*",
            isRequired: true,
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
                  child: Chip(
                      labelPadding: EdgeInsets.zero,
                      padding:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      visualDensity: VisualDensity.comfortable,
                      label: CustomText(addressType[index])
                          .dm()
                          .textColor(Theme.of(context).primaryColor)),
                );
              },
              itemCount: 4,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const CustomTextField(
            hintText: "Enter your own label*",
            isRequired: true,
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
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
