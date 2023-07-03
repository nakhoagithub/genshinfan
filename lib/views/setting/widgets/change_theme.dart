import 'package:flutter/material.dart';
import 'package:genshinfan/app_controller.dart';
import 'package:get/get.dart';

class SwitchThemeApp extends StatelessWidget {
  const SwitchThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AppController appController = Get.find<AppController>();
    return ObxValue(
      (data) {
        return Switch(
          value: data.value,
          onChanged: (value) {
            data.value = value;
            appController.updateTheme(value);
          },
        );
      },
      Get.isDarkMode.obs,
    );
  }
}
