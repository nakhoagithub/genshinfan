import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/outfit/controllers/outfit_controller.dart';
import 'package:genshinfan/models/game/outfit.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_text_multiline_widget.dart';
import 'package:get/get.dart';

class InformationOutfit extends StatelessWidget {
  const InformationOutfit({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    OutfitController outfitController = Get.find<OutfitController>();
    return Obx(() {
      Outfit outfit = outfitController.outfit.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    outfit.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _InformationMore(
                outfit: outfit,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _InformationMore extends StatelessWidget {
  final Outfit outfit;
  const _InformationMore({required this.outfit});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ảnh
          outfit.images?.namesplash == null
              ? const SizedBox()
              : _ImageOutfit(
                  linkImage: Config.urlImage(outfit.images?.namesplash)),

          // nguồn
          outfit.source == null
              ? const SizedBox()
              : InfoTextMultiLineWidget(
                  titleTranslate: "source", data: outfit.source!),

          // mô tả
          InfoParagraphWidget(
            titleTranslate: "description",
            data: outfit.description,
          ),
        ],
      ),
    );
  }
}

class _ImageOutfit extends StatelessWidget {
  final String? linkImage;
  const _ImageOutfit({
    required this.linkImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Get.theme.colorScheme.onBackground.withOpacity(0.2),
      child: CachedNetworkImage(
        imageUrl: linkImage ?? "",
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
