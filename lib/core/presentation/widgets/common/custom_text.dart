import 'package:flutter/material.dart';
import 'package:nomo_app/core/presentation/app_theme/app_theme.dart';
import 'package:nomo_app/core/presentation/app_theme/app_theme_model.dart';
import 'package:nomo_app/core/services/flavor_services/flavor_config.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  final String text;
  final bool showSymbol;

  CustomText(this.text, {super.key, this.showSymbol = false});
  TextStyle _textStyle = const TextStyle();
  final TextThemeStyle _textThemeStyle =
      AppThemeDataModel.fromJson(FlavorConfig.instance!.theme).textThemeStyle;

  final AppThemeDataModel appTheme =
      AppThemeDataModel.fromJson(FlavorConfig.instance!.theme);
  TextAlign? _align;
  TextOverflow? _overflow;
  int? _maxLines;
  @override
  Widget build(BuildContext context) {
    return showSymbol
        ? Text(
            "₹$text",
            style: _textStyle,
            textAlign: _align,
            overflow: _overflow,
            maxLines: _maxLines,
          )
        : Text(
            text,
            style: _textStyle,
            textAlign: _align,
            overflow: _overflow,
            maxLines: _maxLines,
          );
  }
}

extension TextExtension on CustomText {
  CustomText labelM() {
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.labelMedium.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.labelMedium.color),
        fontFamily: _textThemeStyle.labelMedium.fontFamily);
    return this;
  }

  CustomText labelS() {
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.labelSmall.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.labelSmall.color),
        fontFamily: _textThemeStyle.labelSmall.fontFamily);
    return this;
  }

  CustomText labelB() {
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.labelLarge.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.labelLarge.color),
        fontFamily: _textThemeStyle.labelLarge.fontFamily);
    return this;
  }

  CustomText bodyM() {
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.bodyMedium.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.bodyMedium.color),
        fontFamily: _textThemeStyle.bodyMedium.fontFamily);
    return this;
  }

  CustomText ls() {
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.lightSmall.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.lightSmall.color),
      fontFamily: _textThemeStyle.lightSmall.fontFamily,
      fontWeight:
          getFontWeight(fontWeight: _textThemeStyle.lightSmall.fontWeight),
    );
    return this;
  }

  CustomText lm() {
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.lightMedium.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.lightMedium.color),
      fontFamily: _textThemeStyle.lightMedium.fontFamily,
      fontWeight:
          getFontWeight(fontWeight: _textThemeStyle.lightMedium.fontWeight),
    );
    return this;
  }

  CustomText lb() {
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.lightBig.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.lightBig.color),
      fontFamily: _textThemeStyle.lightBig.fontFamily,
      fontWeight:
          getFontWeight(fontWeight: _textThemeStyle.lightBig.fontWeight),
    );
    return this;
  }

  CustomText ds() {
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.darkSmall.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.darkSmall.color),
      fontFamily: _textThemeStyle.lightSmall.fontFamily,
      fontWeight:
          getFontWeight(fontWeight: _textThemeStyle.darkSmall.fontWeight),
    );
    return this;
  }

  CustomText dm() {
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.darkMedium.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.darkMedium.color),
      fontFamily: _textThemeStyle.darkMedium.fontFamily,
      fontWeight:
          getFontWeight(fontWeight: _textThemeStyle.darkMedium.fontWeight),
    );

    return this;
  }

  CustomText dlm() {
    //dark light medium
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.darkMedium.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.darkLightMedium.color),
      fontFamily: _textThemeStyle.darkMedium.fontFamily,
      fontWeight:
          getFontWeight(fontWeight: _textThemeStyle.darkMedium.fontWeight),
    );

    return this;
  }

  CustomText db() {
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.darkBig.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.darkBig.color),
      fontFamily: _textThemeStyle.darkBig.fontFamily,
      fontWeight: getFontWeight(fontWeight: _textThemeStyle.darkBig.fontWeight),
    );
    return this;
  }

  CustomText fontSize(double size) {
    _textStyle = _textStyle.copyWith(
      fontSize: size,
      // color: getColorFromHex(_textThemeStyle.darkBig.color)
    );
    return this;
  }

  CustomText fontWeight(FontWeight fontWeight) {
    _textStyle = _textStyle.copyWith(fontWeight: fontWeight);
    return this;
  }

  CustomText decoration(TextDecoration decoration) {
    _textStyle =
        _textStyle.copyWith(decoration: decoration, decorationThickness: 2.2);
    return this;
  }

  CustomText overflow(TextOverflow textOverflow) {
    _overflow = textOverflow;
    return this;
  }

  CustomText maxLines(int maxLines) {
    _maxLines = maxLines;
    return this;
  }

  CustomText fontFamily(String name) {
    _textStyle = _textStyle.copyWith(fontFamily: name
        // color: getColorFromHex(_textThemeStyle.darkBig.color)
        );
    return this;
  }

  CustomText bold({bool returnBold = true}) {
    if (returnBold) {
      _textStyle = _textStyle.copyWith(fontWeight: FontWeight.bold);
    }

    return this;
  }

  CustomText medium() {
    _textStyle = _textStyle.copyWith(fontWeight: FontWeight.w600);

    return this;
  }

  CustomText primaryColor() {
    _textStyle =
        _textStyle.copyWith(color: getColorFromHex(appTheme.onPrimary));
    return this;
  }

  CustomText textColor(Color txtcolor) {
    _textStyle = _textStyle.copyWith(color: txtcolor);
    return this;
  }

  CustomText hb({Color? fontColor}) {
    // heading large
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.headlineBig.fontSize.toDouble(),
        color: fontColor ?? getColorFromHex(_textThemeStyle.headlineBig.color),
        fontFamily: _textThemeStyle.headlineBig.fontFamily,
        letterSpacing: _textThemeStyle.headlineBig.letterSpacing);
    return this;
  }

  CustomText hm() {
    // black heading medium
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.headlineMedium.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.headlineMedium.color),
      fontFamily: _textThemeStyle.headlineMedium.fontFamily,
    );
    return this;
  }

  CustomText hs() {
    // heading small
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.headlineSmall.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.headlineSmall.color),
        fontFamily: _textThemeStyle.headlineSmall.fontFamily,
        letterSpacing: _textThemeStyle.headlineSmall.letterSpacing);
    return this;
  }

  CustomText dlt() {
     //dark large title
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.titleLarge.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.titleLarge.color),
        fontFamily: _textThemeStyle.titleLarge.fontFamily,
        letterSpacing: _textThemeStyle.titleMedium.letterSpacing);
    return this;
  }

  CustomText dmt() {
    //dark medium title
    _textStyle = _textStyle.copyWith(
      fontSize: _textThemeStyle.titleMedium.fontSize.toDouble(),
      color: getColorFromHex(_textThemeStyle.titleMedium.color),
      fontFamily: _textThemeStyle.titleMedium.fontFamily,
      letterSpacing: _textThemeStyle.titleMedium.letterSpacing,
    );

    return this;
  }

  CustomText tl() {
    //textfield label
    _textStyle = _textStyle.copyWith(
        fontSize: _textThemeStyle.bodySmall.fontSize.toDouble(),
        color: getColorFromHex(_textThemeStyle.bodySmall.color),
        fontFamily: _textThemeStyle.bodySmall.fontFamily);
    return this;
  }

  CustomText left() {
    _align = TextAlign.left;
    return this;
  }

  CustomText right() {
    _align = TextAlign.right;
    return this;
  }

  CustomText center() {
    _align = TextAlign.center;
    return this;
  }
}
