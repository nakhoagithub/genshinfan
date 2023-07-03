import 'package:flutter/material.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      width: Get.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
            margin: const EdgeInsets.all(12),
            child: TextCSS(
              Config.aboutApp,
              style: ThemeApp.textStyle(),
            )),
      ),
    );
  }
}
