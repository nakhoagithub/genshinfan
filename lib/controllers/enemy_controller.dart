import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/resources/utils/enum.dart';
import 'package:get/get.dart';
import '../objects/enemy.dart';

class EnemyController extends GetxController with GetTickerProviderStateMixin {
  List<Enemy> enemies = Get.find<AppController>().enemies;
  Rx<Status> status = Status.init.obs;
  Rx<Enemy?> enemy = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectEnemy(Enemy value) async {
    enemy.value = value;
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
