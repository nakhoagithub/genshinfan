import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/widgets/backbutton.dart';
import 'package:genshinfan/views/enemy/widgets/enemy_info.dart';
import 'package:genshinfan/views/enemy/widgets/enemy_stats.dart';
import 'package:get/get.dart';

class EnemyInfoPage extends StatelessWidget {
  const EnemyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    EnemyController enemyController = Get.find<EnemyController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: ThemeApp.colorCard(isDark: Get.isDarkMode),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "enemy_information".tr,
          ),
        ),
        body: enemyController.enemy.value == null
            ? Center(
                child: Text("choose_enemy".tr),
              )
            : Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: enemyController.scrollController,
                    child: const Column(
                      children: [
                        // thông tin
                        InformationEnemy(),
                        // stat
                        EnemyStats(),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
