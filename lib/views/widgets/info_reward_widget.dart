import 'package:flutter/material.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/domain/widgets/item_reward.dart';
import 'package:get/get.dart';

class InfoRewardWidget extends StatelessWidget {
  final String titleTranslate;
  final List<Reward> data;
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
          style: ThemeApp.textStyle(),
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
                        : ItemReward(
                            name: resource.name,
                            resource: resource,
                            size: Get.width * 0.18,
                            rarity: resource.rarity,
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
