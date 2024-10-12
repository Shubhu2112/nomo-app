import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomo_app/core/services/flavor_services/flavor_config.dart';
import 'app_theme_model.dart';

class AppTheme {
  static ThemeData? buildTheme(BuildContext context) {
    AppThemeDataModel appThemesColors =
        AppThemeDataModel.fromJson(FlavorConfig.instance!.theme);

    return ThemeData(
      tabBarTheme: TabBarTheme(
        unselectedLabelColor:
            HexColor(appThemesColors.tabBar.unselectedLabelColor),
        labelColor: HexColor(appThemesColors.tabBar.labelColor),
      ),
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14.0),
          ),
        ),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  HexColor(appThemesColors.elevatedButtonStyle.color))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: HexColor(appThemesColors.outlinedButtonStyle!.color)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)))),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: appThemesColors.appBar.titleTextStyle.fontFamily,
            fontSize: double.parse(
                appThemesColors.appBar.titleTextStyle.fontSize.toString()),
            letterSpacing: 0.3,
            fontWeight: FontWeight.bold,
            color: HexColor(appThemesColors.appBar.titleTextStyle.color),
          ),
          backgroundColor: HexColor(appThemesColors.appBar.backgroundColor),
          foregroundColor: HexColor(appThemesColors.appBar.foregroundColor),
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.bodyLarge.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.bodyLarge.fontSize.toDouble(),
          fontWeight: FontWeight.bold,
          color: HexColor(appThemesColors.textThemeStyle.bodyLarge.color),
        ),
        bodyMedium: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.bodyMedium.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.bodyMedium.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.bodyMedium.color),
        ),
        bodySmall: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.bodySmall.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.bodySmall.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.bodySmall.color),
        ),
        labelLarge: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.labelLarge.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.labelLarge.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.labelLarge.color),
        ),
        labelMedium: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.labelMedium.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.labelMedium.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.labelMedium.color),
        ),
        labelSmall: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.labelSmall.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.labelSmall.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.labelSmall.color),
        ),
        displayLarge: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.headlineBig.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.headlineBig.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.headlineBig.color),
        ),
        displayMedium: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.headlineMedium.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.headlineMedium.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.headlineMedium.color),
        ),
        displaySmall: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.headlineSmall.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.headlineSmall.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.headlineSmall.color),
        ),
        titleLarge: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.titleLarge.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.titleLarge.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.titleLarge.color),
        ),
        titleMedium: TextStyle(
          fontFamily: appThemesColors.textThemeStyle.titleMedium.fontFamily,
          fontSize:
              appThemesColors.textThemeStyle.titleMedium.fontSize.toDouble(),
          color: HexColor(appThemesColors.textThemeStyle.titleMedium.color),
        ),
      ),
      iconTheme: IconThemeData(color: HexColor(appThemesColors.primary)),
      colorScheme: ColorScheme(
          primary: HexColor(appThemesColors.primary),
          onError: HexColor(appThemesColors.onError),
          error: HexColor(appThemesColors.error),
          onPrimary: HexColor(appThemesColors.onPrimary),
          secondary: HexColor(appThemesColors.secondary),
          onSecondary: HexColor(appThemesColors.onSecondary),
          background: HexColor(appThemesColors.background),
          brightness: Brightness.light,
          onBackground: HexColor(appThemesColors.onBackground),
          surface: HexColor(appThemesColors.surface),
          surfaceBright: HexColor(appThemesColors.surfaceBright),
          onSurface: HexColor(appThemesColors.onSurface),
          outline: HexColor(appThemesColors.outline),
          tertiary: HexColor(appThemesColors.tertiary)),
      primarySwatch: buildMaterialColor(HexColor(appThemesColors.primary)),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorToHex extends Color {
  ///convert material colors to hexcolor
  static int _convertColorToHex(Color color) {
    var hex = '${color.value}';
    return int.parse(
      hex,
    );
  }

  ColorToHex(final Color color) : super(_convertColorToHex(color));
}

FontWeight getFontWeight({String? fontWeight}) {
  switch (fontWeight) {
    case '100':
      return FontWeight.w100;
    case '200':
      return FontWeight.w200;
    case '300':
      return FontWeight.w300;
    case '400':
      return FontWeight.w400;
    case '500':
      return FontWeight.w500;
    case '600':
      return FontWeight.w600;
    case '700':
      return FontWeight.w700;
    case '800':
      return FontWeight.w800;
    case '900':
      return FontWeight.w900;
    default:
      return FontWeight.normal;
  }
}
