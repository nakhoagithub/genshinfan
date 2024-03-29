import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/models/game/reward.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/domain/widgets/item_reward.dart';
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
                    Resource? resource = Tool.getResourceFromName(e.name);
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
