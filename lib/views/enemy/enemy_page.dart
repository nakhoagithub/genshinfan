import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/enemy/widgets/item_enemy.dart';
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
          const Expanded(child: _ListEnemy()),
        ],
      ),
    );
  }
}

class _ListEnemy extends StatelessWidget {
  const _ListEnemy();

  @override
  Widget build(BuildContext context) {
    EnemyController enemyController = Get.find<EnemyController>();
    double sizeItem = 94;
    return LayoutBuilder(builder: (p0, p1) {
      double w = p1.maxWidth;
      return GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: w >= 300 ? 3 : 2,
        childAspectRatio: sizeItem / (sizeItem * 1.215),
        children: List.generate(
          enemyController.enemies.length,
          (index) => FadeInUp(
            child: Center(
              child: SizedBox(
                width: sizeItem,
                height: sizeItem * 1.215,
                child: ItemEnemy(
                  enemy: enemyController.enemies[index],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
