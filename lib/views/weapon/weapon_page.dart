import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/weapon/widgets/dialog_filter.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class WeaponPage extends StatelessWidget {
  const WeaponPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "weapon".tr,
            width: double.infinity,
            actions: [
              IconButton(
                onPressed: () {
                  dialogFilterWeapon();
                },
                icon: const Icon(Icons.filter_alt_rounded),
              )
            ],
          ),
          const Expanded(child: _List()),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Weapon> weapons = weaponController.weapons;
      return SizedBox(
          width: Config.widthCenter,
          child: weapons.isEmpty
              ? ListEmpty(title: "empty_weapon".tr)
              : GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
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
                            iconLeft: Tools.getAssetWeaponType(
                                        weapons[index].weaponType) !=
                                    null
                                ? Image.asset(Tools.getAssetWeaponType(
                                        weapons[index].weaponType) ??
                                    "")
                                : null,
                            linkImage: weapons[index].images?.mihoyoIcon ??
                                Config.urlImage(
                                    weapons[index].images?.filenameGacha),
                            rarity: weapons[index].rarity.toString(),
                            star: true,
                            onTap: () {
                              weaponController.selectWeapon(weapons[index]);
                              homeController.pageCenter();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}
