import 'package:flutter/material.dart';
import 'package:genshinfan/views/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/items.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';

import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/title_of_content.dart';
import 'package:get/get.dart';

class SkillAscensionView extends StatelessWidget {
  final Map<String, List<Items>> costs;
  final String? element;
  const SkillAscensionView({
    super.key,
    required this.costs,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // title
        TitleOfContent(title: "skill_ascension".tr),
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
            // color: Tools.getColorElementCharacter(element).withOpacity(0.5),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 9,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _ItemCost(
                lv: "${index + 2}",
                costs: costs["lvl${index + 2}"],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemCost extends StatelessWidget {
  final String lv;
  final List<Items>? costs;
  const _ItemCost({
    required this.lv,
    required this.costs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              lv,
              style: ThemeApp.textStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: costs == null
                ? null
                : Row(
                    children: [
                      ...costs!.map(
                        (e) {
                          Resource? resource =
                              Tools.getResourceFromName(e.name ?? "");
                          return resource == null
                              ? const SizedBox()
                              : ItemGame(
                                  size: Get.width * 0.18,
                                  title: e.count.toString(),
                                  linkImage: Config.urlImage(
                                      resource.images?.nameicon),
                                  rarity: resource.rarity,
                                  star: true,
                                  onTap: () {
                                    ResourceController resourceController =
                                        Get.find<ResourceController>();
                                    resourceController.selectResource(resource);
                                    Get.toNamed('/resource_info');
                                  });
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
