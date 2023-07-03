import 'package:flutter/material.dart';
import 'package:genshinfan/views/achievement/controllers/achievement_controller.dart';
import 'package:genshinfan/models/game/achievement.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';

class InformationAchievementList extends StatelessWidget {
  const InformationAchievementList({super.key});

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController =
        Get.find<AchievementController>();
    return Obx(() {
      List<Achievement> achievements = achievementController.achievementOfGroup;
      return ListView.builder(
        itemCount: achievements.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _ItemAchievement(
            achievement: achievements[index],
          );
        },
      );
    });
  }
}

class _ItemAchievement extends StatelessWidget {
  final Achievement achievement;
  const _ItemAchievement({
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievement.name,
              style:
                  ThemeApp.textStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _ItemStage(
              stages: achievement.stages,
              stage: achievement.stage1,
              divider: false,
              index: 1,
            ),
            achievement.stage2 == null
                ? const SizedBox()
                : _ItemStage(
                    stages: achievement.stages,
                    stage: achievement.stage2!,
                    index: 2,
                  ),
            achievement.stage3 == null
                ? const SizedBox()
                : _ItemStage(
                    stages: achievement.stages,
                    stage: achievement.stage3!,
                    index: 3,
                  ),
          ],
        ),
      ),
    );
  }
}

class _ItemStage extends StatelessWidget {
  final int stages;
  final StageAchievement stage;
  final bool divider;
  final int index;
  const _ItemStage({
    required this.stages,
    required this.stage,
    this.divider = true,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        divider ? const Divider() : const SizedBox(),
        Row(
          children: [
            Image.asset(
              "assets/images/UI_AchievementIcon_${stages}_$index.png",
              height: 60,
              width: 60,
            ),
            Expanded(
              child: Text(
                Tools.handleDescriptionAchievement(stage.description, stage.progress.toString()),
                style: ThemeApp.textStyle(),
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Text(
                  stage.reward.count?.toStringAsFixed(0) ?? "0",
                  style: ThemeApp.textStyle(),
                ),
                Image.asset(
                  'assets/images/UI_ItemIcon_201.png',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
