import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config.dart';

class ThemeApp {
  static GetStorage box = GetStorage();
  static bool get isDark => box.read(Config.darkMode) ?? true;
  static ThemeData get theme => isDark ? dark() : light();
  static ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  static ThemeData changeTheme({required bool isDark}) {
    box.write(Config.darkMode, isDark);
    Get.changeTheme(isDark ? dark() : light());
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    return isDark ? dark() : light();
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xff00a173),
    );
  }

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xff00a173),
    );
  }

  static TextStyle textStyle({
    Color? color,
    double fontSize = 14,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? Get.theme.colorScheme.onSurface,
      fontSize: fontSize,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
