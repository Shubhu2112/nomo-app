import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final WidgetStatePropertyAll<Color?>? buttonColor;
  final Widget textValue;
  final Color? textColor;
  final VoidCallback? onPress;
  final double? height;
  final double? width;
  final double? radius;
  final double? fontSize;
  final bool isExpanded;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry padding;

  const CustomPrimaryButton(
      {super.key,
      this.buttonColor,
      required this.textValue,
      this.textColor,
      this.onPress,
      this.height,
      this.width,
      this.fontSize,
      this.radius,
      this.isExpanded = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      this.borderSide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
          height: height ?? 40,
          width: isExpanded ? double.infinity : (width ?? 110),
          child: ElevatedButton(
              onPressed: onPress,
              style: ButtonStyle(
                backgroundColor: buttonColor ??
                    WidgetStatePropertyAll(Theme.of(context).primaryColor),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                    side: borderSide ?? BorderSide.none)),
              ),
              child: textValue)

          //  Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     onTap: onPress,
          //     borderRadius: BorderRadius.circular(14.0),
          //     child: Center(
          //       child: Text(
          //         textValue,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //             color: buttonTextColor ??
          //                 Theme.of(context).colorScheme.onPrimary,
          //             fontSize: fontSize ?? 17,
          //             fontFamily: "Roboto-Medium"),
          //         //style: heading4.copyWith(color: textColor),
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
