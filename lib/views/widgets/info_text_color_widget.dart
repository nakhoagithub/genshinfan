import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

class InfoTextColorWidget extends StatelessWidget {
  final String titleTranslate;
  final String data;
  const InfoTextColorWidget({
    super.key,
    required this.titleTranslate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Config.marginText),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "${titleTranslate.tr}: ",
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                color: ThemeApp.colorTextSecond(
                  isDark: Get.isDarkMode,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: TextCSS(
              data,
              textAlign: TextAlign.center,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
