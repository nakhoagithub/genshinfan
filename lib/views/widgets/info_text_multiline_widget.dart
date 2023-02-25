import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class InfoTextMultiLineWidget extends StatelessWidget {
  final String titleTranslate;
  final List<String> data;
  const InfoTextMultiLineWidget({
    super.key,
    required this.titleTranslate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Config.marginText),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Column(
              children: [
                ...data.map(
                  (e) {
                    return Text(
                      e,
                      textAlign: TextAlign.center,
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
