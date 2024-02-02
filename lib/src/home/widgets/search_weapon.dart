import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/weapon/controllers/weapon_controller.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:get/get.dart';

class ListWeapon extends StatelessWidget {
  final List<Weapon> weapons;
  const ListWeapon({super.key, required this.weapons});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return weapons.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "weapon".tr,
                      style: ThemeApp.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: weapons.length,
                      itemBuilder: (context, index) {
                        return Center(
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
                                  Config.urlImage(
                                      weapons[index].images?.namegacha),
                              rarity: weapons[index].rarity.toString(),
                              star: true,
                              onTap: () {
                                Get.find<WeaponController>()
                                    .selectWeapon(weapons[index]);
                                Get.toNamed('/weapon_info');
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
