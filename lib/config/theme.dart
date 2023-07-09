import 'package:flutter_fashion/app/presentation/home/export.dart';

final font = PrimaryFont.instance;

class ThemeDataApp {
  ThemeDataApp._() {
    _init();
  }

  static ThemeDataApp? _instance;

  static ThemeDataApp get instance => _instance ??= ThemeDataApp._();

  bool _isLight = true;

  bool get isLight => _isLight;

  set setLightTheme(bool value) {
    _isLight = value;
  }

  _init() async {
    _isLight = await HydratedBloc.storage.read("SettingsCubit")["isThemeLight"];
  }

  static ThemeData appThemeLight = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    cardColor: lightColor.withOpacity(0.9),
    indicatorColor: darkColor,
    dividerColor: scaffoldBackgroundColor,
    iconTheme: const IconThemeData(size: 18.0, color: blackColor),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusBtn),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      surfaceTintColor: scaffoldBackgroundColor,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      titleSmall: font.copyWith(
        fontSize: 20.0,
      ),
      bodyLarge: font.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: font.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w300,
      ),
      bodySmall: font.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      iconColor: darkColor.withOpacity(0.7),
      hintStyle: PrimaryFont.instance.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
        color: blackColor.withOpacity(0.65),
      ),
      fillColor: lightColor,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusBtn),
        ),
      ),
    ),
  );

  static ThemeData appThemeDark = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: blackColor,
    indicatorColor: lightColor.withOpacity(0.75),
    cardColor: lightColor.withOpacity(0.1),
    dividerColor: scaffoldBackgroundColor.withOpacity(0.4),
    iconTheme: IconThemeData(size: 18.0, color: lightColor.withOpacity(0.75)),
    appBarTheme: const AppBarTheme(
      backgroundColor: blackColor,
      surfaceTintColor: blackColor,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      titleSmall: font.copyWith(
        color: lightColor.withOpacity(0.75),
        fontSize: 20.0,
      ),
      bodyLarge: font.copyWith(
        fontSize: 18.0,
        color: lightColor.withOpacity(0.75),
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: font.copyWith(
        fontSize: 16.0,
        color: lightColor.withOpacity(0.75),
        fontWeight: FontWeight.w300,
      ),
      bodySmall: font.copyWith(
        fontSize: 12.0,
        color: lightColor.withOpacity(0.75),
        fontWeight: FontWeight.w300,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      iconColor: primaryColor.withOpacity(0.7),
      fillColor: lightColor.withOpacity(0.1),
      hintStyle: PrimaryFont.instance.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
        color: lightColor.withOpacity(0.8),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusBtn),
        ),
      ),
    ),
  );
}
