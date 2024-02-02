import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import '../../../models/game/enemy.dart';

class EnemyController extends GetxController with GetTickerProviderStateMixin {
  List<Enemy> enemies = Get.find<MainController>().enemies;
  Rx<Status> status = Status.init.obs;
  Rx<Enemy?> enemy = Rx(null);

  void selectEnemy(Enemy value) async {
    enemy.value = value;
  }
}
