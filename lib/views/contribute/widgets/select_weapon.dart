import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/contribute/widgets/dialog_weapon.dart';
import 'package:genshinfan/views/weapon/widgets/item_weapon.dart';
import 'package:get/get.dart';

class SelectWeapon extends StatelessWidget {
  const SelectWeapon({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    double sizeItem = 94;
    return FadeInRight(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              "weapon".tr,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                dialogContributeWeapon();
              },
              child: Container(
                height: sizeItem * 1.215,
                width: sizeItem,
                decoration: BoxDecoration(
                  border: Border.all(
                    // color: ThemeApp.colorText(isDark: Get.isDarkMode),
                  ),
                  borderRadius: BorderRadius.circular(sizeItem * 0.05),
                ),
                child: Obx(
                  () {
                    return contributeCharacterController.weapon.value == null
                        ? const Icon(Icons.add, size: 35)
                        : ItemWeapon(
                            weapon: contributeCharacterController.weapon.value!,
                            onTap: () {
                              dialogContributeWeapon();
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
