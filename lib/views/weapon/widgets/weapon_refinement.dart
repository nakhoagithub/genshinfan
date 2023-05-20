import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/title_of_content.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

class WeaponRefinement extends StatelessWidget {
  const WeaponRefinement({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WeaponController weaponController = Get.find<WeaponController>();
    return Obx(() {
      Weapon weapon = weaponController.weapon.value!;
      WeaponRefine? r1 = weapon.r1;
      WeaponRefine? r2 = weapon.r2;
      WeaponRefine? r3 = weapon.r3;
      WeaponRefine? r4 = weapon.r4;
      WeaponRefine? r5 = weapon.r5;
      return weapon.effectTemplateRaw == null
          ? const SizedBox()
          : Column(
              children: [
                // title
                TitleOfContent(title: "refinement".tr),

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
                        child: TextCSS(
                          Tools.handleRefinementWeapon(
                              weapon.effectTemplateRaw, r1, r2, r3, r4, r5),
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
