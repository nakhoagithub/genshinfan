import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/windglider/controllers/windglider_controller.dart';
import 'package:genshinfan/models/windglider.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_text_multiline_widget.dart';
import 'package:get/get.dart';

class InformationWindglider extends StatelessWidget {
  const InformationWindglider({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WindgliderController windgliderController =
        Get.find<WindgliderController>();
    return Obx(() {
      Windglider windglider = windgliderController.windglider.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageWindglider(
                linkImage: Config.urlImage(windglider.images?.nameicon),
                rarity: "1",
                size: 150,
              ),
              Center(
                child: Text(
                  windglider.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _InformationMore(
                windglider: windglider,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageWindglider extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageWindglider({
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
  final Windglider windglider;
  const _InformationMore({required this.windglider});

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
          // nguồn
          InfoTextMultiLineWidget(
              titleTranslate: "source", data: windglider.source),

          // description
          InfoParagraphWidget(
              titleTranslate: "description", data: windglider.description),

          InfoParagraphWidget(titleTranslate: "story", data: windglider.story),
        ],
      ),
    );
  }
}
