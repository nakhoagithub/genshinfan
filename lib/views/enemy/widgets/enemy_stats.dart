import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/widgets/title_of_content.dart';
import 'package:get/get.dart';

import '../../../controllers/enemy_controller.dart';
import '../../../objects/enemy.dart';
import '../../../resources/widgets/item_table.dart';

class EnemyStats extends StatelessWidget {
  const EnemyStats({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    EnemyController enemyController = Get.find<EnemyController>();

    return Obx(() {
      Enemy enemy = enemyController.enemy.value!;
      List<Stat>? stats = enemy.stats;
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
                color: ThemeApp.colorText(isDark: Get.isDarkMode),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: ThemeApp.colorPrimary(isDark: Get.isDarkMode)
                        .withOpacity(0.3),
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
                      child: ItemTable(title: "hp".tr),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: ItemTable(title: "def".tr),
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
                            ? ThemeApp.colorText(isDark: !Get.isDarkMode)
                                .withOpacity(0.5)
                            : null,
                      ),
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ItemTable(title: "${value.level}"),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child:
                              ItemTable(title: value.attack.toStringAsFixed(0)),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ItemTable(title: value.hp.toStringAsFixed(0)),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: ItemTable(
                              title: value.defense.toStringAsFixed(0)),
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
