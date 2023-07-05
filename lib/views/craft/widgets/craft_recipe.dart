import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/craft.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/domain/widgets/item_reward.dart';
import 'package:get/get.dart';

class CraftRecipe extends StatelessWidget {
  final List<CraftIngredient> craftIngredients;
  final VoidCallback? onTap;
  const CraftRecipe({
    super.key,
    required this.craftIngredients,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    for (int i = craftIngredients.length; i < 3; i++) {
      craftIngredients.add(const CraftIngredient(name: "", count: 0));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${"recipe".tr}: ",
          style: ThemeApp.textStyle(),
        ),
        SizedBox(
          height: Get.width * 0.25,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: craftIngredients.length,
            itemBuilder: (context, index) {
              Resource? resource =
                  Tool.getResourceFromName(craftIngredients[index].name);
              return Center(
                child: ItemReward(
                  size: Get.width * 0.20,
                  resource: resource,
                  rarity: resource?.rarity ?? "0",
                  contentIfNotImage: craftIngredients[index].name,
                  name: craftIngredients[index].count.toString(),
                  noData: craftIngredients[index].count == 0,
                  onTap: onTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
