import 'package:flutter/material.dart';

import 'custom_text.dart';

class SharedUi {
 static void showCustomDialog(BuildContext context, {required Widget child}) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.white,
      pageBuilder: (_, __, ___) {
        return child;
      },
    );
  }

  String? validator(String? value) {
    return null;
  }

  InputDecoration textFieldInputDecoration(BuildContext context,
      {String? hintText, required String labelText, Icon? suffix}) {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText ?? "",

        // floatingLabelAlignment: FloatingLabelAlignment.center,

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).inputDecorationTheme.focusColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always);
  }

  InputDecoration sharedDropDownDecoration(
      {required String hintText, required String labelText, Icon? suffix}) {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(fontSize: 14),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always);
  }

  Widget sharedButton(
    String text, {
    required Function() onPressed,
    double? width,
    double? height,
  }) {
    return SizedBox(
        width: width ?? double.infinity,
        height: height ?? 60,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ))),
            onPressed: () {
              onPressed();
            },
            child: CustomText(text).ds()));
  }

  Widget sharedButtonExpanded(
    String text,
    BuildContext context, {
    required Function() onPressed,
    bool isOutline = false,
    double? height,
  }) {
    return SizedBox(
      height: height ?? 60,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(isOutline
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(
                          color: isOutline
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent)))),
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            style: TextStyle(
                color: isOutline
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary),
          )),
    );
  }
}
