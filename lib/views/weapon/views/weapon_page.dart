import 'package:flutter/material.dart';
import 'package:genshinfan/views/app_layout.dart';
import 'package:genshinfan/views/weapon/controllers/weapon_controller.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class WeaponPage extends StatelessWidget {
  const WeaponPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    return Obx(() {
      List<Weapon> weapons = weaponController.weaponsView;
      return weapons.isEmpty
          ? ListEmpty(title: "empty_weapon".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<AppLayoutController>().crossAxisCount(),
              childAspectRatio:
                  Get.find<AppLayoutController>().childAspectRatio(),
              children: List.generate(
                weapons.length,
                (index) => ItemGame(
                  title: weapons[index].name,
                  iconLeft:
                      Tool.getAssetWeaponType(weapons[index].weapontype) != null
                          ? Image.asset(Tool.getAssetWeaponType(
                                  weapons[index].weapontype) ??
                              "")
                          : null,
                  linkImage: weapons[index].images?.icon ??
                      Config.urlImage(weapons[index].images?.namegacha),
                  rarity: weapons[index].rarity.toString(),
                  star: true,
                  onTap: () {
                    weaponController.selectWeapon(weapons[index]);
                    Get.toNamed("/weapon_info");
                  },
                ),
              ),
            );
    });
  }
}
