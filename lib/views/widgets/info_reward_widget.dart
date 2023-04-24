import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward_preview.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class InfoRewardWidget extends StatelessWidget {
  final String titleTranslate;
  final List<Rewardpreview> data;
  const InfoRewardWidget({
    super.key,
    required this.titleTranslate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${"reward".tr}: ",
          style: ThemeApp.textStyle(
            isDark: Get.isDarkMode,
            // color: ThemeApp.colorTextSecond(
            //   isDark: Get.isDarkMode,
            // ),
          ),
        ),
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                ...data.map(
                  (e) {
                    Resource? resource = Tools.getResourceFromName(e.name);
                    return resource == null
                        ? const SizedBox()
                        : ItemGame(
                            size: Get.width * 0.18,
                            title: e.name,
                            linkImage:
                                Config.urlImage(resource.images?.nameicon),
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
        ),
      ],
    );
  }
}
