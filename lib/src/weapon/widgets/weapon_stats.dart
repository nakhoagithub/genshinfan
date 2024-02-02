import 'package:flutter/material.dart';
import 'package:genshinfan/src/weapon/controllers/weapon_controller.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/widgets/item_table.dart';
import 'package:genshinfan/src/widgets/title_of_content.dart';
import 'package:get/get.dart';

class WeaponStats extends StatelessWidget {
  const WeaponStats({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WeaponController weaponController = Get.find<WeaponController>();

    return Obx(() {
      Weapon weapon = weaponController.weapon.value!;
      List<Stat>? stats = weapon.stats;
      return Column(
        children: [
          // title
          TitleOfContent(title: "stats".tr),

          // content
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Table(
              border: TableBorder.all(
                color: Get.theme.colorScheme.onSurface,
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.primary.withOpacity(0.2),
                  ),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: ItemTable(title: "level".tr),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: ItemTable(title: "attack".tr),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: ItemTable(
                        title: weapon.specialized == null
                            ? "-"
                            : "${weapon.specialized}".tr,
                      ),
                    ),
                  ],
                ),
                ...?stats?.asMap().entries.map(
                  (e) {
                    int index = e.key;
                    Stat value = e.value;
                    return TableRow(
                      decoration: BoxDecoration(
                        color: index % 2 == 1
                            ? Get.theme.colorScheme.tertiary.withOpacity(0.5)
                            : null,
                      ),
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ItemTable(
                              title: "${value.level}${value.bonus ? "+" : ""}"),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child:
                              ItemTable(title: value.attack.toStringAsFixed(0)),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ItemTable(
                            title: weapon.specialized == null
                                ? "-"
                                : Tool.handlerSpecializedStat(
                                    weapon.specialized, value.specialized),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ],
            ),
          ),
        ],
      );
    });
  }
}
