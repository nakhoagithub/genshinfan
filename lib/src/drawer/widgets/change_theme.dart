import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:get/get.dart';

class SwitchThemeApp extends StatelessWidget {
  const SwitchThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    MainController appController = Get.find<MainController>();
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
