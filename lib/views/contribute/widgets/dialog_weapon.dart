import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/contribute/controllers/contribute_character_controller.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/back_button.dart';

import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

dialogContributeWeapon() async {
  await Get.bottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    SizedBox(
      height: Get.height * 0.9,
      width: Get.width,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(
            icon: Icons.keyboard_arrow_down_rounded,
          ),
          title: Text("weapon".tr),
        ),
        body: const _ListWeapon(),
      ),
    ),
    isScrollControlled: true,
  );
}

class _ListWeapon extends StatelessWidget {
  const _ListWeapon();

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    double sizeItem = 94;
    return Obx(() {
      List<Weapon> weapons = contributeCharacterController.weapons;
      return weapons.isEmpty
          ? Center(
              child: Text('select_character'.tr),
            )
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.width >= 400 ? 4 : 3,
              childAspectRatio: sizeItem / (sizeItem * 1.215),
              children: List.generate(
                weapons.length,
                (index) => FadeInUp(
                  child: Center(
                    child: SizedBox(
                      width: sizeItem,
                      height: sizeItem * 1.215,
                      child: ItemGame(
                        title: weapons[index].name,
                        iconLeft: Tool.getAssetWeaponType(
                                    weapons[index].weapontype) !=
                                null
                            ? Image.asset(Tool.getAssetWeaponType(
                                    weapons[index].weapontype) ??
                                "")
                            : null,
                        linkImage: weapons[index].images?.icon ??
                            Config.urlImage(weapons[index].images?.namegacha),
                        rarity: weapons[index].rarity.toString(),
                        star: true,
                        onTap: () {
                          Get.find<ContributeCharacterController>()
                              .selectWeapon(weapons[index]);
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
