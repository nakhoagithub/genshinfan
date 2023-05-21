import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/craft_controller.dart';
import 'package:genshinfan/objects/craft.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/craft/widgets/craft_recipe.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:get/get.dart';

class InformationCraft extends StatelessWidget {
  const InformationCraft({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CraftController craftController = Get.find<CraftController>();
    return Obx(() {
      Craft craft = craftController.craft.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageCraft(
                linkImage: Config.urlImage(craft.resource?.images?.nameicon),
                rarity: craft.resource?.rarity ?? "1",
                size: 150,
              ),
              Center(
                child: Text(
                  craft.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _InformationMore(
                craft: craft,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageCraft extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageCraft({
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
  final Craft craft;
  const _InformationMore({required this.craft});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // category
          InfoTextWidget(
              titleTranslate: "unlockrank", data: craft.unlockrank.toString()),

          CraftRecipe(craftIngredients: craft.recipe),
        ],
      ),
    );
  }
}