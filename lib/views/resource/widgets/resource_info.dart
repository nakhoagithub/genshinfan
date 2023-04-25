import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/info_daysofweek_widget.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_rarity_widget.dart';
import 'package:genshinfan/views/widgets/info_text_multiline_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
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
                    fontSize: 32,
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
          return const Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_rounded,
              color: Colors.black54,
              size: 20,
            ),
          );
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
