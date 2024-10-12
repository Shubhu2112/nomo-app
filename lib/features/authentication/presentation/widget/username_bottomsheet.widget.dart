import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_button.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_textfield.dart';

class UsernameBottomSheet {
  static void show(
      BuildContext context, Function(String value) userNameCallback) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Ensures the bottom sheet adjusts with the keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0), // Rounded corners at the top
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            // Adjust bottom padding based on keyboard height
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Adjusting container height to allow room for keyboard, but not full screen
          child: SizedBox(
            height: 270, // Fixed height for the bottom sheet content
            child: UserNameForm(
              userNameCallback: (value) {
                userNameCallback(value);
              },
            ),
          ),
        );
      },
    );
  }
}

class UserNameForm extends StatelessWidget {
  final Function(String value)? userNameCallback;
  const UserNameForm({super.key, this.userNameCallback});

  @override
  Widget build(BuildContext context) {
    String? userName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText("What's Your Name?").db(),
        const SizedBox(
          height: 12,
        ),
        CustomTextField(
          hintText: "Name*",
          isRequired: true,
          autofocus: true,
          onChanged: (value) {
            userName = value;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: CustomPrimaryButton(
            textValue: CustomText("Submit")
                .db()
                .textColor(Theme.of(context).colorScheme.surface),
            onPress: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              userNameCallback!(userName ?? "");
            },
          ),
        )
      ],
    );
  }
}
