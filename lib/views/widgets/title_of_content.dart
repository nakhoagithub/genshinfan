import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class TitleOfContent extends StatelessWidget {
  final String title;
  const TitleOfContent({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(top: 20, bottom: 5),
          child: Divider(
            height: 2,
            color: ThemeApp.colorText(
              isDark: Get.isDarkMode,
            ),
          ),
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: ThemeApp.textStyle(
              isDark: Get.isDarkMode,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeApp.colorText(
                isDark: Get.isDarkMode,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
