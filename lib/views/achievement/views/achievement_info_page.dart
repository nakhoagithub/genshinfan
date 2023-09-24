import 'package:flutter/material.dart';
import 'package:genshinfan/views/achievement/controllers/achievement_controller.dart';
import 'package:genshinfan/views/achievement/widgets/achievement_info.dart';
import 'package:genshinfan/views/achievement/widgets/achievementgroup_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class AchievementInfoPage extends StatelessWidget {
  const AchievementInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AchievementController achievementController =
        Get.find<AchievementController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "achievement_information".tr,
          ),
        ),
        body: achievementController.achievementGroup.value == null
            ? PageEmpty(title: "select_achievement".tr)
            : const Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationAchievementGroup(),
                        InformationAchievementList(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
