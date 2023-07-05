import 'package:flutter/material.dart';
import 'package:genshinfan/views/enemy/controllers/enemy_controller.dart';

import 'package:genshinfan/views/enemy/widgets/enemy_info.dart';
import 'package:genshinfan/views/enemy/widgets/enemy_stats.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
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
          leading: const BackButton(),
          centerTitle: true,
          title: Text(
            "enemy_information".tr,
          ),
        ),
        body: enemyController.enemy.value == null
            ? PageEmpty(title: "select_enemy".tr)
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
