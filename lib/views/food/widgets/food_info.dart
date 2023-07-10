import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/food/controllers/food_controller.dart';
import 'package:genshinfan/models/game/food.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/food/widgets/food_ingredient.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:get/get.dart';

class InformationFood extends StatelessWidget {
  const InformationFood({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    FoodController foodController = Get.find<FoodController>();
    return Obx(() {
      Food food = foodController.food.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageFood(
                linkImage: Config.urlImage(food.images?.nameicon),
                rarity: food.rarity,
                size: 150,
              ),
              Center(
                child: Text(
                  food.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const FoodIngredientWidget(),
              _InformationMore(food: food),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageFood extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageFood({
    required this.linkImage,
    required this.rarity,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: GradientApp.getBackgroundRarity(rarity),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: linkImage ?? "",
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          return const CircularProgressApp();
        },
        errorWidget: (context, url, error) {
          return const ImageFailure();
        },
      ),
    );
  }
}

class _InformationMore extends StatelessWidget {
  final Food food;
  const _InformationMore({required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // category
          // InfoTextWidget(titleTranslate: "category", data: food),

          // counttype
          // InfoTextWidget(titleTranslate: "counttype", data: food.counttype),

          // description
          InfoParagraphWidget(
              titleTranslate: "description", data: food.description),
        ],
      ),
    );
  }
}
