import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import '../../../models/game/food.dart';

class FoodController extends GetxController with GetTickerProviderStateMixin {
  List<Food> foods = Get.find<MainController>().foods;
  Rx<Status> status = Status.init.obs;
  Rx<Food?> food = Rx(null);

  void selectFood(Food value) async {
    food.value = value;
  }
}
