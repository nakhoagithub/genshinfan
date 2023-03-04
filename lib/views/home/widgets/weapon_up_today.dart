import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:genshinfan/views/weapon/widgets/item_weapon.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class ListWeaponUpToday extends StatelessWidget {
  const ListWeaponUpToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = 94;
    List<Weapon>? weaponUpToday = WeaponService().getWeaponUpToday();
    return weaponUpToday == null
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
                        isDark: Get.isDarkMode,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: InkWell(
                        onTap: () async {
                          dialogInfo("weapon_up_today".tr);
                        },
                        child: const Icon(
                          Icons.help_outline_rounded,
                          size: 18,
                        ),
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
                      itemCount: weaponUpToday.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SizedBox(
                            width: sizeItem,
                            height: sizeItem * 1.215,
                            child: ItemWeapon(
                              weapon: weaponUpToday[index],
                              onTap: () {
                                Get.find<WeaponController>()
                                    .selectWeapon(weaponUpToday[index]);
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
