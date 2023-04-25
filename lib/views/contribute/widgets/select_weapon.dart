import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/contribute/widgets/dialog_weapon.dart';
import 'package:genshinfan/views/widgets/item.dart';
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
                      // color: ThemeApp.colorText(),
                      ),
                  borderRadius: BorderRadius.circular(sizeItem * 0.05),
                ),
                child: Obx(
                  () {
                    Weapon? w = contributeCharacterController.weapon.value;
                    return w == null
                        ? const Icon(Icons.add, size: 35)
                        : ItemGame(
                            title: w.name,
                            iconLeft: Tools.getAssetWeaponType(w.weapontype) !=
                                    null
                                ? Image.asset(
                                    Tools.getAssetWeaponType(w.weapontype) ??
                                        "")
                                : null,
                            linkImage: w.images?.icon ??
                                Config.urlImage(w.images?.namegacha),
                            rarity: w.rarity,
                            star: true,
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
