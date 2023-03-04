import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class PageEmpty extends StatelessWidget {
  final String title;
  const PageEmpty({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: ThemeApp.textStyle(isDark: Get.isDarkMode),
      ),
    );
  }
}
