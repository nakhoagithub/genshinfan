import 'package:flutter/widgets.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/achievement.dart';
import 'package:genshinfan/models/game/namecard.dart';
import 'package:get/get.dart';

class AchievementController extends GetxController {
  List<AchievementGroup> achievementGroups =
      Get.find<MainController>().achievementGroups;
  List<Achievement> achievements = Get.find<MainController>().achievements;
  Rx<AchievementGroup?> achievementGroup = Rx(null);
  Rx<Namecard?> namecardReward = Rx(null);
  Map<String, List<Achievement>> mapAchievementOfGroup = {};
  RxList<Achievement> achievementOfGroup = <Achievement>[].obs;

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
      namecardReward.value = Get.find<MainController>()
          .namecards
          .firstWhereOrNull((element) => element.name == value.reward!.name);
    }
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
}
