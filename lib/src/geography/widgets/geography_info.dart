import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/src/geography/controllers/geography_controller.dart';
import 'package:genshinfan/models/game/geography.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/widgets/circular_progress.dart';
import 'package:genshinfan/src/widgets/image_failure.dart';
import 'package:genshinfan/src/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/src/widgets/info_text_widget.dart';
import 'package:get/get.dart';

class InformationGeography extends StatelessWidget {
  const InformationGeography({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    GeographyController geographyController = Get.find<GeographyController>();
    return Obx(() {
      Geography geography = geographyController.geography.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Center(
                child: Text(
                  geography.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // ảnh
              _ImageGeography(
                linkImage: Config.urlImage(geography.images?.nameimage),
              ),

              _InformationMore(geography: geography),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageGeography extends StatelessWidget {
  final String? linkImage;
  const _ImageGeography({
    required this.linkImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
  final Geography geography;
  const _InformationMore({required this.geography});

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
          // vùng
          geography.region == ""
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "region", data: geography.region),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: geography.description),
        ],
      ),
    );
  }
}
