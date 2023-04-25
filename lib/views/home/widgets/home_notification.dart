import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

class HomeNotification extends StatelessWidget {
  const HomeNotification({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "notification".tr,
            style: ThemeApp.textStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          TextCSS(
            "note_home".tr,
            style: ThemeApp.textStyle(),
          ),
        ],
      ),
    );
  }
}
