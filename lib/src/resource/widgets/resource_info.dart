import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/src/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/craft.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/craft/widgets/craft_recipe.dart';
import 'package:genshinfan/src/widgets/circular_progress.dart';
import 'package:genshinfan/src/widgets/gradient.dart';
import 'package:genshinfan/src/widgets/image_failure.dart';
import 'package:genshinfan/src/widgets/info_daysofweek_widget.dart';
import 'package:genshinfan/src/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/src/widgets/info_rarity_widget.dart';
import 'package:genshinfan/src/widgets/info_text_multiline_widget.dart';
import 'package:genshinfan/src/widgets/info_text_widget.dart';
import 'package:get/get.dart';

class InformationResource extends StatelessWidget {
  const InformationResource({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ResourceController resourceController = Get.find<ResourceController>();
    return Obx(() {
      Resource resource = resourceController.resource.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageResource(
                linkImage: Config.urlImage(resource.images?.nameicon),
                rarity: resource.rarity,
                size: 150,
              ),
              Center(
                child: Text(
                  resource.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _InformationMore(
                resource: resource,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageResource extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageResource({
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
  final Resource resource;
  const _InformationMore({required this.resource});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Craft? craft = Tool.getCraftFromKey(resource.key);
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // độ hiếm
          resource.rarity == null
              ? const SizedBox()
              : InfoRarityWidget(rarity: resource.rarity!),

          // dupealias
          resource.dupealias == null
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "dupealias", data: resource.dupealias!),

          // loại
          InfoTextWidget(titleTranslate: "type", data: resource.materialtype),

          // Nguồn
          resource.source.isEmpty
              ? const SizedBox()
              : InfoTextMultiLineWidget(
                  titleTranslate: "source", data: resource.source),

          craft == null
              ? const SizedBox()
              : CraftRecipe(
                  craftIngredients: craft.recipe,
                  onTap: () {},
                ),

          // domain
          resource.dropdomain == null
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "domain", data: resource.dropdomain!),

          // Ngày mở bí cảnh
          resource.daysofweek == null
              ? const SizedBox()
              : InfoDaysOfWeekWidget(data: resource.daysofweek!),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: resource.description),
        ],
      ),
    );
  }
}
