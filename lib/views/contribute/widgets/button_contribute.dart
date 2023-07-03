import 'package:flutter/material.dart';
import 'package:genshinfan/views/contribute/controllers/contribute_character_controller.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ButtonContributeCharacter extends StatelessWidget {
  const ButtonContributeCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    ContributeCharacterController controller =
        Get.find<ContributeCharacterController>();
    return RoundedLoadingButton(
      controller: controller.buttonController,
      onPressed: () async {
        await controller.contribute();
      },
      height: 45,
      width: 200,
      color: ThemeApp.theme.primaryColor,
      successColor: Colors.green.shade700,
      child: Text("contribute".tr),
    );
  }
}
