import 'package:flutter/material.dart';
import 'package:genshinfan/src/food/controllers/food_controller.dart';
import 'package:genshinfan/models/game/food.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("food".tr),
      ),
      body: const _List(),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    FoodController foodController = Get.find<FoodController>();
    return Obx(() {
      List<Food> foods = foodController.foods;
      return foods.isEmpty
          ? ListEmpty(title: "empty_food".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                foods.length,
                (index) => ItemGame(
                  title: foods[index].name,
                  rarity: foods[index].rarity,
                  linkImage: Config.urlImage(foods[index].images?.nameicon),
                  onTap: () {
                    foodController.selectFood(foods[index]);
                    Get.toNamed("/food_info");
                  },
                ),
              ),
            );
    });
  }
}
