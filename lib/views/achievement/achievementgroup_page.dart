import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/achievement/controllers/achievement_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/achievement.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class AchievementGroupPage extends StatelessWidget {
  const AchievementGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "achievementGroup".tr,
            width: double.infinity,
          ),
          const Expanded(
            child: _List(),
          )
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController =
        Get.find<AchievementController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem2;
    return Obx(() {
      List<AchievementGroup> achievementGroups =
          achievementController.achievementGroups;
      return achievementGroups.isEmpty
          ? ListEmpty(title: "empty_achievementGroup".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio: sizeItem / (sizeItem * 1.215),
              children: List.generate(
                achievementGroups.length,
                (index) => FadeInUp(
                  child: Center(
                    child: SizedBox(
                      width: sizeItem,
                      height: sizeItem * 1.215,
                      child: _ItemAchievementGroup(
                        achievementGroup: achievementGroups[index],
                        onTap: () {
                          achievementController
                              .selectAchievementGroup(achievementGroups[index]);
                          homeController.pageCenter();
                        },
                      ),
                    ),
                  ),
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
    double sizeItem = Config.sizeItem2;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(sizeItem * 0.05),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Get.theme.colorScheme.onInverseSurface,
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: Config.urlImage(achievementGroup.images?.nameicon),
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeApp.textStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
