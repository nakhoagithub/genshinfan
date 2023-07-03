import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/enemy/controllers/enemy_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/enemy.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class EnemyPage extends StatelessWidget {
  const EnemyPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "enemy".tr,
            width: double.infinity,
          ),
          const Expanded(child: _List()),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    EnemyController enemyController = Get.find<EnemyController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Enemy> enemies = enemyController.enemies;
      return SizedBox(
          width: Config.widthCenter,
          child: enemies.isEmpty
              ? ListEmpty(title: "empty_enemy".tr)
              : GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  childAspectRatio: sizeItem / (sizeItem * 1.215),
                  children: List.generate(
                    enemies.length,
                    (index) => FadeInUp(
                      child: Center(
                        child: SizedBox(
                          width: sizeItem,
                          height: sizeItem * 1.215,
                          child: ItemGame(
                            title: enemies[index].name,
                            linkImage: Config.urlImage(
                                enemies[index].images?.nameicon),
                            onTap: () {
                              enemyController.selectEnemy(enemies[index]);
                              homeController.pageCenter();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}
