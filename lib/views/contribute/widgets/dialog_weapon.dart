import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/objects/weapon.dart';

import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/weapon/widgets/item_weapon.dart';
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
              child: Text('choose_character'.tr),
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
                      child: ItemWeapon(
                        weapon: weapons[index],
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
