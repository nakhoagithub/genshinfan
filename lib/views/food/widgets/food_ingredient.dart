import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/food.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/food/controllers/food_controller.dart';
import 'package:genshinfan/views/resource/controllers/resource_controller.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class FoodIngredientWidget extends StatelessWidget {
  const FoodIngredientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Food? food = Get.find<FoodController>().food.value;
    List<FoodIngredient> foodIngredients = food?.ingredients ?? [];
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"ingredient".tr}: ",
            style: ThemeApp.textStyle(),
          ),
          SizedBox(
            height: Get.width * 0.25,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: foodIngredients.length,
              itemBuilder: (context, index) {
                Resource? resource =
                    Tool.getResourceFromName(foodIngredients[index].name);
                return ItemGame(
                  size: Get.width * 0.18,
                  title: foodIngredients[index].count.toString(),
                  rarity: resource?.rarity ?? "1",
                  linkImage: resource?.images?.redirect,
                  onTap: () {
                    if (resource != null) {
                      Get.find<ResourceController>().selectResource(resource);
                      Get.toNamed('/resource_info');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
