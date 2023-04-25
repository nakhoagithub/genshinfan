import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/localization.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Row(
      children: [
        Text(
          Localization.getLanguageFromCode(Get.locale).language,
          style: ThemeApp.textStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Icon(Icons.keyboard_arrow_right_rounded)
      ],
    );
  }
}
