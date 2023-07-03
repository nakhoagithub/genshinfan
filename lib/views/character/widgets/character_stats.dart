import 'package:flutter/material.dart';
import 'package:genshinfan/views/character/controllers/character_controller.dart';
import 'package:genshinfan/models/character.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/item_table.dart';
import 'package:genshinfan/views/widgets/title_of_content.dart';
import 'package:get/get.dart';

class CharacterStats extends StatelessWidget {
  const CharacterStats({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CharacterController characterController = Get.find<CharacterController>();
    return Obx(() {
      Character character = characterController.character.value!;
      List<Stat>? stats = character.stats;
      return Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      color: Get.theme.colorScheme.tertiary.withOpacity(0.2),
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
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: ItemTable(
                          title: character.substat,
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
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: ItemTable(
                                title:
                                    "${value.level}${value.bonus ? "+" : ""}"),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: ItemTable(
                                title: value.attack.toStringAsFixed(0)),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child:
                                ItemTable(title: value.hp.toStringAsFixed(0)),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: ItemTable(
                                title: value.defense.toStringAsFixed(0)),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: ItemTable(
                              title: Tools.handlerSpecializedStat(
                                  character.substat, value.specialized),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
