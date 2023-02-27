import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/views/weapon/widgets/item_weapon.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
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
            onTapAction: () {},
          ),
          const Expanded(child: _ListWeapon()),
        ],
      ),
    );
  }
}

class _ListWeapon extends StatelessWidget {
  const _ListWeapon();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    double sizeItem = 94;
    return LayoutBuilder(builder: (p0, p1) {
      double w = p1.maxWidth;
      return GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: w >= 300 ? 3 : 2,
        childAspectRatio: sizeItem / (sizeItem * 1.215),
        children: List.generate(
          weaponController.weapons.length,
          (index) => FadeInUp(
            child: Center(
              child: SizedBox(
                width: sizeItem,
                height: sizeItem * 1.215,
                child: ItemWeapon(
                  weapon: weaponController.weapons[index],
                  onTap: () {
                    WeaponController weaponController =
                        Get.find<WeaponController>();
                    weaponController.selectWeapon(weaponController.weapons[index]);
                    HomeController homeController = Get.find<HomeController>();
                    homeController.pageCenter();
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
