import 'package:flutter/material.dart';
import 'package:genshinfan/src/achievement/controllers/achievement_controller.dart';
import 'package:genshinfan/models/game/achievement.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/achievement/widgets/item_reward.dart';
import 'package:get/get.dart';

class InformationAchievementGroup extends StatelessWidget {
  const InformationAchievementGroup({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AchievementController achievementController =
        Get.find<AchievementController>();
    return Obx(() {
      AchievementGroup achievementGroup =
          achievementController.achievementGroup.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    achievementGroup.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _InformationMore(
                achievementGroup: achievementGroup,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _InformationMore extends StatelessWidget {
  final AchievementGroup achievementGroup;
  const _InformationMore({required this.achievementGroup});

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController =
        Get.find<AchievementController>();
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // phần thưởng khi hoàn thành toàn bộ thành tựu
          achievementGroup.reward == null
              ? const SizedBox()
              : ItemRewardAchievementGroup(
                  namecard: achievementController.namecardReward.value),
        ],
      ),
    );
  }
}
