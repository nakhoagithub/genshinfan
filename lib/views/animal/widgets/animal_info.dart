import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/animal_controller.dart';
import 'package:genshinfan/objects/animal.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:get/get.dart';

class InformationAnimal extends StatelessWidget {
  const InformationAnimal({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AnimalController animalController = Get.find<AnimalController>();
    return Obx(() {
      Animal animal = animalController.animal.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageAnimal(
                linkImage: Config.urlImage(animal.images?.nameicon),
                rarity: "1",
                size: 150,
              ),
              Center(
                child: Text(
                  animal.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _InformationMore(
                animal: animal,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageAnimal extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageAnimal({
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
  final Animal animal;
  const _InformationMore({required this.animal});

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
          InfoTextWidget(titleTranslate: "category", data: animal.category),

          // counttype
          // InfoTextWidget(titleTranslate: "counttype", data: animal.counttype),

          // description
          InfoParagraphWidget(
              titleTranslate: "description", data: animal.description),
        ],
      ),
    );
  }
}
