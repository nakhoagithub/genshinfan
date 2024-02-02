import 'package:flutter/material.dart';
import 'package:genshinfan/src/enemy/controllers/enemy_controller.dart';
import 'package:genshinfan/models/game/enemy.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class EnemyPage extends StatelessWidget {
  const EnemyPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("enemy".tr),
      ),
      body: const _List(),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    EnemyController enemyController = Get.find<EnemyController>();
    return Obx(() {
      List<Enemy> enemies = enemyController.enemies;
      return enemies.isEmpty
          ? ListEmpty(title: "empty_enemy".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                enemies.length,
                (index) => ItemGame(
                  title: enemies[index].name,
                  linkImage: Config.urlImage(enemies[index].images?.nameicon),
                  onTap: () {
                    enemyController.selectEnemy(enemies[index]);
                    Get.toNamed("/enemy_info");
                  },
                ),
              ),
            );
    });
  }
}
