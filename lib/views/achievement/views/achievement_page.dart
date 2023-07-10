import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/app_layout.dart';
import 'package:genshinfan/views/achievement/controllers/achievement_controller.dart';
import 'package:genshinfan/models/game/achievement.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class AchievementGroupPage extends StatelessWidget {
  const AchievementGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController =
        Get.find<AchievementController>();
    return Obx(() {
      List<AchievementGroup> achievementGroups =
          achievementController.achievementGroups;
      return achievementGroups.isEmpty
          ? ListEmpty(title: "empty_achievementGroup".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<AppLayoutController>().crossAxisCountBig(),
              childAspectRatio: Get.find<AppLayoutController>().childAspectRatioBig(),
              children: List.generate(
                achievementGroups.length,
                (index) => _ItemAchievementGroup(
                  achievementGroup: achievementGroups[index],
                  onTap: () {
                    achievementController
                        .selectAchievementGroup(achievementGroups[index]);
                    Get.toNamed("/achievement_info");
                  },
                ),
              ),
            );
    });
  }
}

class _ItemAchievementGroup extends StatelessWidget {
  final AchievementGroup achievementGroup;
  final VoidCallback onTap;
  const _ItemAchievementGroup({
    required this.achievementGroup,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<AppLayoutController>().widthItemBig;
    return Center(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Get.theme.colorScheme.onInverseSurface,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(sizeItem * 0.05),
          child: Container(
            width: sizeItem,
            height: sizeItem * 1.215,
            margin: const EdgeInsets.all(4),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl:
                        Config.urlImage(achievementGroup.images?.nameicon),
                    fit: BoxFit.cover,
                    height: sizeItem * 0.6,
                    width: sizeItem * 0.6,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const CircularProgressApp();
                    },
                    errorWidget: (context, url, error) {
                      return const ImageFailure();
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      achievementGroup.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeApp.textStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}