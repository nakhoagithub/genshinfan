import 'package:flutter/material.dart';
import 'package:genshinfan/src/enemy/controllers/enemy_controller.dart';

import 'package:genshinfan/src/enemy/widgets/enemy_info.dart';
import 'package:genshinfan/src/enemy/widgets/enemy_stats.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class EnemyInfoPage extends StatelessWidget {
  const EnemyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    EnemyController enemyController = Get.find<EnemyController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "enemy_information".tr,
          ),
        ),
        body: enemyController.enemy.value == null
            ? PageEmpty(title: "select_enemy".tr)
            : const Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // thông tin
                        InformationEnemy(),
                        // stat
                        EnemyStats(),
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
