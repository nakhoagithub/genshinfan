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

  // static Color get colorBackgroundItemInPage => const Color(0xffebe7de);

  // static Color colorPrimary({
  //   bool? isDark,
  // }) {
  //   return isDark == null
  //       ? const Color(0xff00a173)
  //       : isDark
  //           ? const Color(0xff00a173)
  //           : const Color(0xff00a173);
  // }

  // static Color colorScaffold({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xff202225) : const Color(0xfff1f1f1);
  // }

  // static Color colorCard({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xff2f3136) : const Color(0xffffffff);
  // }

  // static Color colorBackgroundButton({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xff2f3136) : const Color(0xfff2f3f5);
  // }

  // static Color colorIcon({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xffffffff) : const Color(0xff697380);
  // }

  // static Color colorBackgroundIcon({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xff2f3236) : const Color(0xffffffff);
  // }

  // static Color colorText({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xffe1e1e1) : const Color(0xff1e1e1e);
  // }

  // static Color colorTextSecond({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xff93959a) : const Color(0xff626b76);
  // }

  // static Color colorClickItem({
  //   required bool isDark,
  // }) {
  //   return isDark ? const Color(0xff42464d) : const Color(0xffdbdee1);
  // }

  // static TabBarTheme tabBarTheme({required bool isDark}) {
  //   return TabBarTheme(
  //     unselectedLabelColor: colorText(isDark: isDark).withOpacity(0.5),
  //     indicatorColor: colorText(isDark: isDark),
  //     labelColor: colorText(isDark: isDark),
  //     dividerColor: colorText(isDark: isDark),
  //   );
  // }

  // static AppBarTheme appBarTheme({required bool isDark}) {
  //   if (isDark) {
  //     return AppBarTheme(
  //       backgroundColor: const Color(0xff292b2f),
  //       iconTheme: IconThemeData(
  //         color: colorText(isDark: true),
  //       ),
  //       titleTextStyle: textStyle(
  //         isDark: true,
  //         fontSize: 18,
  //       ),
  //     );
  //   } else {
  //     return AppBarTheme(
  //       backgroundColor: const Color(0xffffffff),
  //       iconTheme: IconThemeData(
  //         color: colorText(
  //           isDark: false,
  //         ),
  //       ),
  //       titleTextStyle: textStyle(
  //         isDark: false,
  //         fontSize: 18,
  //       ),
  //     );
  //   }
  // }

  static TextStyle textStyle({
    Color? color,
    double fontSize = 16,
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
