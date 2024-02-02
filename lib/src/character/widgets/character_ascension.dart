import 'package:flutter/material.dart';
import 'package:genshinfan/src/character/controllers/character_controller.dart';
import 'package:genshinfan/src/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/items.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/title_of_content.dart';
import 'package:get/get.dart';

class CharacterAscensionView extends StatelessWidget {
  const CharacterAscensionView({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CharacterController characterController = Get.find<CharacterController>();
    return Obx(() {
      Costs? costs = characterController.character.value!.costs;
      return costs == null
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // title
                  TitleOfContent(title: "ascension".tr),

                  // content
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        strokeAlign: 1,
                        color: Get.theme.colorScheme.onSurface,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _ItemAscend(
                          lv: "20",
                          rank: "1",
                          ascends: costs.ascend1,
                        ),
                        _ItemAscend(
                          lv: "40",
                          rank: "2",
                          ascends: costs.ascend2,
                        ),
                        _ItemAscend(
                          lv: "50",
                          rank: "3",
                          ascends: costs.ascend3,
                        ),
                        _ItemAscend(
                          lv: "60",
                          rank: "4",
                          ascends: costs.ascend4,
                        ),
                        _ItemAscend(
                          lv: "70",
                          rank: "5",
                          ascends: costs.ascend5,
                        ),
                        _ItemAscend(
                          lv: "80",
                          rank: "6",
                          ascends: costs.ascend6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}

class _ItemAscend extends StatelessWidget {
  final String rank;
  final String lv;
  final List<Items> ascends;
  const _ItemAscend({
    required this.rank,
    required this.lv,
    required this.ascends,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${"ascend".tr}: $rank",
                style: ThemeApp.textStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              Text(
                "${"level".tr}: $lv",
                style: ThemeApp.textStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              ...ascends.map(
                (e) {
                  Resource? resource = Tool.getResourceFromName(e.name ?? "");
                  return resource == null
                      ? const SizedBox()
                      : ItemGame(
                          size: Get.width * 0.18,
                          title: e.count.toString(),
                          linkImage: resource.images?.redirect,
                          rarity: resource.rarity,
                          star: true,
                          onTap: () {
                            ResourceController resourceController =
                                Get.find<ResourceController>();
                            resourceController.selectResource(resource);
                            Get.toNamed('/resource_info');
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
