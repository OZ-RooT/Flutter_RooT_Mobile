import 'package:flutter/material.dart';

class ThemeColors {
  final Color gray0;
  final Color gray50;
  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;
  final Color theme;
  final Color red;
  final Color yellow;
  final Color green;
  final Color primary;
  final Color primaryLight;
  final Color primaryLightActive;


  ThemeColors({
    required this.theme,
    required this.gray0,
    required this.gray50,
    required this.gray100,
    required this.gray200,
    required this.gray300,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray800,
    required this.gray900,
    required this.red,
    required this.yellow,
    required this.green,
    required this.primary,
    required this.primaryLight,
    required this.primaryLightActive,
  });

  static ThemeColors of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ThemeColors(
      theme: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xffFFFFFF),
      gray0: isDarkMode ? const Color(0xff000000) : const Color(0xffFFFFFF),
      gray50: isDarkMode ? const Color(0xff212121) : const Color(0xffFAFAFA),
      gray100: isDarkMode ? const Color(0xff202026) : const Color(0xffF5F5F5),
      gray200: isDarkMode ? const Color(0xff2C2C33) : const Color(0xffEEEEEE),
      gray300: isDarkMode ? const Color(0xff424249) : const Color(0xffE0E0E0),
      gray400: isDarkMode ? const Color(0xff83838C) : const Color(0xffBDBDBD),
      gray500: isDarkMode ? const Color(0xff9897A0) : const Color(0xff9E9E9E),
      gray600: isDarkMode ? const Color(0xffB5B5BC) : const Color(0xff757575),
      gray700: isDarkMode ? const Color(0xffC8C8D2) : const Color(0xff616161),
      gray800: isDarkMode ? const Color(0xffDADAE4) : const Color(0xff424242),
      gray900: isDarkMode ? const Color(0xffF9F9FD) : const Color(0xff212121),
      red: isDarkMode ? const Color(0xffD32F2F) : const Color(0xffD32F2F),
      yellow: isDarkMode ? const Color(0xffF9A825) : const Color(0xffF9A825),
      green: isDarkMode ? const Color(0xff4CAF50) : const Color(0xff4CAF50),
      primary: isDarkMode ? const Color(0xff38C172) : const Color(0xff249D57),
      primaryLight: isDarkMode ? const Color(0xff0D371E) : const Color(0xffE9F5EE),
      primaryLightActive: isDarkMode ? const Color(0xff0D371E) : const Color(0xffBBE1CB),
    );
  }
}