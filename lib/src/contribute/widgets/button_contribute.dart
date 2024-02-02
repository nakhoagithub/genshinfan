import 'package:flutter/material.dart';
import 'package:genshinfan/src/contribute/controllers/contribute_character_controller.dart';
import 'package:get/get.dart';

class ButtonContributeCharacter extends StatelessWidget {
  const ButtonContributeCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    ContributeCharacterController controller =
        Get.find<ContributeCharacterController>();
    return ElevatedButton(
      onPressed: () async {
        await controller.contribute();
      },
      child: Text("contribute".tr),
    );
  }
}
