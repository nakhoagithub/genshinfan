import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/widgets/backbutton.dart';
import 'package:genshinfan/views/contribute/widgets/button_contribute.dart';
import 'package:genshinfan/views/contribute/widgets/select_character.dart';
import 'package:genshinfan/views/contribute/widgets/select_circlet.dart';
import 'package:genshinfan/views/contribute/widgets/select_goblet.dart';
import 'package:genshinfan/views/contribute/widgets/select_item_artifact.dart';
import 'package:genshinfan/views/contribute/widgets/select_sands.dart';
import 'package:genshinfan/views/contribute/widgets/select_type.dart';
import 'package:genshinfan/views/contribute/widgets/select_weapon.dart';
import 'package:get/get.dart';

class ContributeCharacterBuildingPage extends StatelessWidget {
  const ContributeCharacterBuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    Get.put(ContributeCharacterController());
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("contribute".tr),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SelectCharacterAndWeapon(),
            SelectTypeSet(),
            _SelectArtifact(),
            SelectSandsEffect(),
            SelectGobletEffect(),
            SelectCircletEffect(),
            SizedBox(height: 50),
            ButtonContributeCharacter(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _SelectCharacterAndWeapon extends StatelessWidget {
  const _SelectCharacterAndWeapon();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectCharacter(),
        SizedBox(width: 20),
        SelectWeapon(),
      ],
    );
  }
}

class _SelectArtifact extends StatelessWidget {
  const _SelectArtifact();

  @override
  Widget build(BuildContext context) {
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            "artifact".tr,
            style: ThemeApp.textStyle(
              isDark: Get.isDarkMode,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(
            () => Column(
              children: [
                const ContributeItemArtifact(type: 0),
                contributeCharacterController.type.value == 1
                    ? const SizedBox()
                    : const ContributeItemArtifact(type: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
