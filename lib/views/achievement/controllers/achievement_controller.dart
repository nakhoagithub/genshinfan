import 'package:flutter/widgets.dart';
import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/models/achievement.dart';
import 'package:genshinfan/models/namecard.dart';
import 'package:get/get.dart';

class AchievementController extends GetxController {
  List<AchievementGroup> achievementGroups =
      Get.find<AppController>().achievementGroups;
  List<Achievement> achievements = Get.find<AppController>().achievements;
  Rx<AchievementGroup?> achievementGroup = Rx(null);
  Rx<Namecard?> namecardReward = Rx(null);
  Map<String, List<Achievement>> mapAchievementOfGroup = {};
  RxList<Achievement> achievementOfGroup = <Achievement>[].obs;
  ScrollController scrollController = ScrollController();

  void selectAchievementGroup(AchievementGroup value) {
    achievementGroup.value = value;
    if (value.key != null) {
      achievementOfGroup.value = mapAchievementOfGroup[value.key] ?? [];
      achievementOfGroup.sort(
        (a, b) {
          return a.sortorder.compareTo(b.sortorder);
        },
      );
    }

    if (value.reward != null) {
      namecardReward.value = Get.find<AppController>()
          .namecards
          .firstWhereOrNull((element) => element.name == value.reward!.name);
    }

    update();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    super.update(ids, condition);
  }

  @override
  void onInit() {
    for (AchievementGroup gr in achievementGroups) {
      List<Achievement> achs = achievements
          .where((element) => element.achievementgroup == gr.name)
          .toList();
      if (gr.key != null) {
        mapAchievementOfGroup.addAll({gr.key!: achs});
      }
    }

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
