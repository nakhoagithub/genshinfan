import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/character/widgets/item_character.dart';
import 'package:genshinfan/views/contribute/widgets/dialog_character.dart';
import 'package:get/get.dart';

class SelectCharacter extends StatelessWidget {
  const SelectCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    double sizeItem = 94;
    return FadeInLeft(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              "character".tr,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                dialogContributeCharacter();
              },
              child: Container(
                height: sizeItem * 1.215,
                width: sizeItem,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: ThemeApp.colorText(isDark: Get.isDarkMode)),
                  borderRadius: BorderRadius.circular(sizeItem * 0.05),
                ),
                child: Obx(
                  () {
                    return contributeCharacterController.character.value == null
                        ? const Icon(Icons.add, size: 35)
                        : ItemCharacter(
                            character:
                                contributeCharacterController.character.value!,
                            onTap: () {
                              dialogContributeCharacter();
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
