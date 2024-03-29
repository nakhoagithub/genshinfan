import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/widgets/title_of_content.dart';
import 'package:get/get.dart';

import '../controllers/weapon_controller.dart';

class WeaponStory extends StatelessWidget {
  const WeaponStory({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WeaponController weaponController = Get.find<WeaponController>();

    return Obx(() {
      Weapon weapon = weaponController.weapon.value!;
      return weapon.story == ""
          ? const SizedBox()
          : Column(
              children: [
                // title
                TitleOfContent(title: "story".tr),
                // content
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      strokeAlign: 1,
                      // color: ThemeApp.colorText(),
                    ),
                  ),
                  child: Column(
                    children: [
                      // refinement
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Text(
                          weapon.story,
                          style: ThemeApp.textStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
