
import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class TitleApp extends StatelessWidget {
  final String title;
  const TitleApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10),
      child: Text(
        title,
        style: ThemeApp.textStyle(
          isDark: Get.isDarkMode,
          fontSize: 14,
        ),
      ),
    );
  }
}