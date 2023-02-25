import 'package:flutter/material.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/views/character/widgets/item_ascend_character.dart';
import 'package:get/get.dart';

import '../../../objects/talent.dart';
import '../../../resources/utils/theme.dart';
import '../../../resources/utils/tools.dart';
import '../../../resources/widgets/title_of_content.dart';

class SkillAscensionView extends StatelessWidget {
  final Map<String, List<Cost>> costs;
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
              color: ThemeApp.colorText(isDark: Get.isDarkMode),
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
  final List<Cost>? costs;
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ThemeApp.colorText(isDark: Get.isDarkMode),
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
                              Tools.getResourceFromName(e.name);
                          return resource == null
                              ? const SizedBox()
                              : ItemAscendCharacter(
                                  resource: resource, count: e.count);
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