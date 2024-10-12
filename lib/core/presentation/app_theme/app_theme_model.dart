import 'dart:convert';

AppThemeDataModel appThemeDataModelFromJson(String str) =>
    AppThemeDataModel.fromJson(json.decode(str));

String appThemeDataModelToJson(AppThemeDataModel data) =>
    json.encode(data.toJson());

class AppThemeDataModel {
  AppThemeDataModel(
      {required this.primary,
      required this.error,
      required this.onError,
      required this.onPrimary,
      required this.secondary,
      required this.onSecondary,
      required this.background,
      required this.brightness,
      required this.onBackground,
      required this.surface,
      required this.surfaceBright,
      required this.onSurface,
      required this.primarySwatch,
      required this.appBar,
      required this.elevatedButtonStyle,
      this.outlinedButtonStyle,
      required this.textThemeStyle,
      required this.tabBar,
      required this.outline,
      required this.tertiary});

  String primary;
  String error;
  String onError;
  String onPrimary;
  String secondary;
  String onSecondary;
  String background;
  String brightness;
  String onBackground;
  String surface;
  String surfaceBright;
  String onSurface;
  String primarySwatch;
  String outline;
  String tertiary;
  AppBar appBar;
  EdButtonStyle elevatedButtonStyle;
  EdButtonStyle? outlinedButtonStyle;
  TextThemeStyle textThemeStyle;
  TabBar tabBar;

  factory AppThemeDataModel.fromJson(Map<String, dynamic> json) =>
      AppThemeDataModel(
          primary: json["primary"],
          error: json["error"],
          onError: json["onError"],
          onPrimary: json["onPrimary"],
          secondary: json["secondary"],
          onSecondary: json["onSecondary"],
          background: json["background"],
          brightness: json["brightness"],
          onBackground: json["onBackground"],
          surface: json["surface"],
          surfaceBright: json["surfaceBright"],
          onSurface: json["onSurface"],
          outline: json["outline"],
          primarySwatch: json["primarySwatch"],
          appBar: AppBar.fromJson(json["appBar"]),
          elevatedButtonStyle:
              EdButtonStyle?.fromJson(json["elevatedButtonStyle"]),
          outlinedButtonStyle:
              EdButtonStyle?.fromJson(json["outlinedButtonStyle"]),
          textThemeStyle: TextThemeStyle.fromJson(json["textThemeStyle"]),
          tabBar: TabBar.fromJson(json["tabBar"]),
          tertiary: json["tertiary"]);

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "error": error,
        "onError": onError,
        "onPrimary": onPrimary,
        "secondary": secondary,
        "onSecondary": onSecondary,
        "background": background,
        "brightness": brightness,
        "onBackground": onBackground,
        "surface": surface,
        "onSurface": onSurface,
        "surfaceBright": surfaceBright,
        "primarySwatch": primarySwatch,
        "outline": outline,
        "tertiary": tertiary,
        "appBar": appBar.toJson(),
        "elevatedButtonStyle": elevatedButtonStyle.toJson(),
        "outlinedButtonStyle": outlinedButtonStyle?.toJson(),
        "textThemeStyle": textThemeStyle.toJson(),
        "tabBar": tabBar.toJson(),
      };
}

class TabBar {
  TabBar({
    required this.indicatorWeight,
    required this.unselectedLabelColor,
    required this.indicatorColor,
    required this.labelColor,
  });

  int indicatorWeight;
  String unselectedLabelColor;
  String indicatorColor;
  String labelColor;

  factory TabBar.fromJson(Map<String, dynamic> json) => TabBar(
        indicatorWeight: json["indicatorWeight"],
        unselectedLabelColor: json["unselectedLabelColor"],
        indicatorColor: json["indicatorColor"],
        labelColor: json["labelColor"],
      );

  Map<String, dynamic> toJson() => {
        "indicatorWeight": indicatorWeight,
        "unselectedLabelColor": unselectedLabelColor,
        "indicatorColor": indicatorColor,
        "labelColor": labelColor,
      };
}

class AppBar {
  AppBar({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.titleTextStyle,
  });

  String backgroundColor;
  String foregroundColor;
  TitleTextStyle titleTextStyle;

  factory AppBar.fromJson(Map<String, dynamic> json) => AppBar(
        backgroundColor: json["backgroundColor"],
        foregroundColor: json["foregroundColor"],
        titleTextStyle: TitleTextStyle.fromJson(json["titleTextStyle"]),
      );

  Map<String, dynamic> toJson() => {
        "backgroundColor": backgroundColor,
        "foregroundColor": foregroundColor,
        "titleTextStyle": titleTextStyle.toJson(),
      };
}

class TitleTextStyle {
  TitleTextStyle({
    required this.fontFamily,
    required this.fontSize,
    required this.color,
    this.fontWeight,
    this.letterSpacing,
  });

  String fontFamily;
  int fontSize;
  String color;
  double? letterSpacing;
  String? fontWeight;

  factory TitleTextStyle.fromJson(Map<String, dynamic> json) => TitleTextStyle(
      fontFamily: json["fontFamily"],
      fontSize: json["fontSize"],
      color: json["color"],
      letterSpacing: json["letterSpacing"],
      fontWeight: json["fontWeight"]);

  Map<String, dynamic> toJson() => {
        "fontFamily": fontFamily,
        "fontSize": fontSize,
        "color": color,
        "letterSpacing": letterSpacing,
        "fontWeight": fontWeight
      };
}

class EdButtonStyle {
  EdButtonStyle({
    required this.color,
  });

  String color;

  factory EdButtonStyle.fromJson(Map<String, dynamic> json) => EdButtonStyle(
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
      };
}

class TextThemeStyle {
  TextThemeStyle(
      {required this.bodyLarge,
      required this.bodyMedium,
      required this.bodySmall,
      required this.labelLarge,
      required this.labelMedium,
      required this.labelSmall,
      required this.lightBig,
      required this.lightMedium,
      required this.lightSmall,
      required this.darkBig,
      required this.darkMedium,
      required this.darkSmall,
      required this.darkLightMedium,
      required this.headlineBig,
      required this.headlineMedium,
      required this.headlineSmall,
      required this.titleLarge,
      required this.titleMedium});

  TitleTextStyle bodyLarge;
  TitleTextStyle bodyMedium;
  TitleTextStyle bodySmall;
  TitleTextStyle labelLarge;
  TitleTextStyle labelMedium;
  TitleTextStyle labelSmall;

  TitleTextStyle lightBig;
  TitleTextStyle lightMedium;
  TitleTextStyle lightSmall;
  TitleTextStyle darkBig;
  TitleTextStyle darkMedium;
  TitleTextStyle darkSmall;
  TitleTextStyle darkLightMedium;

  TitleTextStyle headlineBig;
  TitleTextStyle headlineMedium;
  TitleTextStyle headlineSmall;

  TitleTextStyle titleLarge;
  TitleTextStyle titleMedium;

  factory TextThemeStyle.fromJson(Map<String, dynamic> json) => TextThemeStyle(
        bodyLarge: TitleTextStyle.fromJson(json["bodyLarge"]),
        bodyMedium: TitleTextStyle.fromJson(json["bodyMedium"]),
        bodySmall: TitleTextStyle.fromJson(json["bodySmall"]),
        labelLarge: TitleTextStyle.fromJson(json["labelLarge"]),
        labelMedium: TitleTextStyle.fromJson(json["labelMedium"]),
        labelSmall: TitleTextStyle.fromJson(json["labelSmall"]),
        lightBig: TitleTextStyle.fromJson(json["lightBig"]),
        lightMedium: TitleTextStyle.fromJson(json["lightMedium"]),
        lightSmall: TitleTextStyle.fromJson(json["lightSmall"]),
        darkBig: TitleTextStyle.fromJson(json["darkBig"]),
        darkMedium: TitleTextStyle.fromJson(json["darkMedium"]),
        darkSmall: TitleTextStyle.fromJson(json["darkSmall"]),
        darkLightMedium: TitleTextStyle.fromJson(json["darkLightMedium"]),
        headlineBig: TitleTextStyle.fromJson(json["headlineBig"]),
        headlineMedium: TitleTextStyle.fromJson(json["headlineMedium"]),
        headlineSmall: TitleTextStyle.fromJson(json["headlineSmall"]),
        titleLarge: TitleTextStyle.fromJson(json["titleLarge"]),
        titleMedium: TitleTextStyle.fromJson(json["titleMedium"]),
      );

  Map<String, dynamic> toJson() => {
        "bodyLarge": bodyLarge.toJson(),
        "bodyMedium": bodyMedium.toJson(),
        "bodySmall": bodySmall.toJson(),
        "labelLarge": labelLarge.toJson(),
        "labelMedium": labelMedium.toJson(),
        "labelSmall": labelSmall.toJson(),
        "lightBig": lightBig.toJson(),
        "lightMedium": lightMedium.toJson(),
        "lightSmall": lightSmall.toJson(),
        "darkBig": darkBig.toJson(),
        "darkMedium": darkMedium.toJson(),
        "darkSmall": darkSmall.toJson(),
        "darkLightMedium": darkLightMedium.toJson(),
        "headlineBig": headlineBig.toJson(),
        "headlineMedium": headlineMedium.toJson(),
        "headlineSmall": headlineSmall.toJson(),
        "titleLarge": titleLarge.toJson(),
        "titleMedium": titleMedium.toJson()
      };
}
