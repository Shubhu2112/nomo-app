

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomo_app/core/presentation/widgets/common/custom_text.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final bool? isReadOnly;
  final String? labelText;
  final String? label;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? hintText;
  final bool isRequired;
  final String? value;
  final String? defaultValue;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPress;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextCapitalization? capitalization;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final RegExp? regx;
  final Icon? prefixIcon;
  final Widget? prefix;
  final String? counterText;
  final bool? isEnable;
  final bool? isObsecuretext;
  final bool? autocorrect;
  final bool? filled;
  final Color? fillColor;
  final Color? focusedColor;
  final Color? enabledBorder;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;
  final InputBorder? inputBorder;
  final Border? border;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final void Function(String)? onFieldSubmitted;
  final void Function(String value)? onSave;
  // String? Function(String?)? validator;

  const CustomTextField(
      {super.key,
      this.focusNode,
      this.value = "",
      this.regx,
      this.isReadOnly,
      this.labelText,
      this.hintText,
      this.controller,
      this.isRequired = false,
      this.autofocus = false,
      this.textInputAction,
      this.prefix,
      this.fillColor,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      this.maxLines,
      this.defaultValue,
      this.onChanged,
      this.textInputType,
      this.onPress,
      this.isEnable,
      this.label,
      this.capitalization,
      this.maxLength,
      this.textInputFormatter,
      this.isObsecuretext = false,
      this.autocorrect = true,
      this.counterText,
      this.filled,
      this.focusedColor,
      this.enabledBorder,
      this.borderRadius,
      this.contentPadding,
      this.isDense,
      this.inputBorder,
      this.border,
      this.textAlign,
      this.textAlignVertical,
      this.onFieldSubmitted,
      this.onSave,
      this.suffix});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  List<TextInputFormatter> inputFormatter = [];

  bool isError = false;
  bool _validationError = false;
  @override
  void initState() {
    super.initState();

    if (widget.defaultValue != null) {
      if (kDebugMode) {
        print('default text - ${widget.defaultValue}');
      }
      Future.delayed(const Duration(microseconds: 100), () {
        widget.controller?.text = widget.defaultValue!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.controller.text == '') {
    // isError = true;
    // _validationError = false;
    // } else {
    // if (widget.validator != null) {1234
    // if (widget.validator!(widget.controller.text) != null) {
    // isError = false;
    // _validationError = false;
    // } else {
    // isError = true;
    // _validationError = true;
    // }
    // } else {
    // isError = false;
    // _validationError = false;
    // }
    // }

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Row(
              children: [
                CustomText(widget.label ?? "")
                    .tl()
                    .textColor(Theme.of(context).primaryColorDark),
                widget.isRequired
                    ? CustomText(" *")
                        .tl()
                        .textColor(Theme.of(context).colorScheme.error)
                    : Container()
              ],
            ),
          if (widget.label != null) const SizedBox(height: 7),
          TextFormField(
            autofocus: widget.autofocus,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 16,
                fontFamily: "Roboto-Regular"),
            textAlign: widget.textAlign ?? TextAlign.left,
            textAlignVertical: widget.textAlignVertical,
            inputFormatters: widget.textInputFormatter ?? [],
            focusNode: widget.focusNode ?? FocusNode(),
            obscureText: widget.isObsecuretext ?? false,
            maxLength: widget.maxLength,
            autocorrect: widget.autocorrect ?? true,
            textCapitalization:
                widget.capitalization ?? TextCapitalization.none,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            validator: widget.validator ??
                (value) {
                  if (widget.isRequired &&
                      (value == null || value.trim().isEmpty || value == "")) {
                    isError = true;
                    return "This is a required field";
                  }
                  if (widget.isRequired && widget.regx != null) {
                    if (!widget.regx!.hasMatch(value!)) {
                      isError = true;
                      return "Please enter valid detail";
                    }
                  }
                  if (value!.isNotEmpty &&
                      widget.regx != null &&
                      !widget.regx!.hasMatch(value)) {
                    isError = true;
                    return "Please enter valid detail";
                  }

                  return null;
                },
            //initialValue: widget.value ?? "",
            readOnly: widget.isReadOnly != null ? widget.isReadOnly! : false,
            onTap: widget.onPress,
            onSaved: (newValue) {
              widget.onSave?.call(newValue ?? "");
            },
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.textInputType ?? TextInputType.text,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            enabled: widget.isEnable ?? true,
            decoration: InputDecoration(
                isDense: widget.isDense,
                filled: widget.filled,
                fillColor: widget.fillColor ?? Colors.transparent,
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.fromLTRB(10, 15, 10, 15),
                errorStyle: const TextStyle(fontSize: 14),
                labelText: widget.labelText,
                floatingLabelStyle: TextStyle(
                  color: _validationError
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onSecondary,
                ),
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surfaceBright),
                counterText: widget.counterText,
                prefix: widget.prefix,
                suffix: widget.suffix,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 7.0)),
                    borderSide: BorderSide(
                        color: widget.focusedColor ??
                            Theme.of(context).colorScheme.onSecondary)),
                focusedBorder: widget.inputBorder ??
                    OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius ?? 7.0)),
                        borderSide: BorderSide(
                            color: widget.focusedColor ??
                                Theme.of(context).colorScheme.onSecondary)),
                enabledBorder: widget.inputBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 7.0)),
                      borderSide: BorderSide(
                          color: _validationError
                              ? Theme.of(context).colorScheme.error
                              : widget.enabledBorder ??
                                  Theme.of(context).colorScheme.surfaceBright),
                    ),
                border: widget.inputBorder ??
                    OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius ?? 7.0)),
                        borderSide: BorderSide(
                            color: _validationError
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.outline)),
                errorBorder: widget.inputBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 7.0)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error),
                    ),
                labelStyle: TextStyle(
                  color: _validationError
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onSecondary,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto),
          ),
        ],
      ),
    );
  }
}
