import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/weapon/controllers/weapon_controller.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class ListWeaponUpToday extends StatelessWidget {
  const ListWeaponUpToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    HomeController homeController = Get.find<HomeController>();
    return Obx(() {
      List<Weapon> weaponUpToday = homeController.weaponUpToday;
      return weaponUpToday.isEmpty
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
                              child: ItemGame(
                                title: weaponUpToday[index].name,
                                iconLeft: Tool.getAssetWeaponType(
                                            weaponUpToday[index].weapontype) !=
                                        null
                                    ? Image.asset(Tool.getAssetWeaponType(
                                            weaponUpToday[index].weapontype) ??
                                        "")
                                    : null,
                                linkImage: weaponUpToday[index].images?.icon ??
                                    Config.urlImage(
                                        weaponUpToday[index].images?.namegacha),
                                rarity: weaponUpToday[index].rarity.toString(),
                                star: true,
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
    });
  }
}
