import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import '../../../models/game/food.dart';

class FoodController extends GetxController with GetTickerProviderStateMixin {
  List<Food> foods = Get.find<MainController>().foods;
  Rx<Status> status = Status.init.obs;
  Rx<Food?> food = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectFood(Food value) async {
    food.value = value;
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
