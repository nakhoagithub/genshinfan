import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/namecard/controllers/namecard_controller.dart';
import 'package:genshinfan/models/game/namecard.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_text_multiline_widget.dart';
import 'package:get/get.dart';

class InformationNamecard extends StatelessWidget {
  const InformationNamecard({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    NamecardController namecardController = Get.find<NamecardController>();
    return Obx(() {
      Namecard namecard = namecardController.namecard.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Center(
                child: Text(
                  namecard.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _ImageNamecard(
                linkImage: Config.urlImage(namecard.images?.namebackground),
              ),
              namecard.images?.namebanner == null
                  ? const SizedBox()
                  : _ImageNamebanner(
                      linkImage: Config.urlImage(namecard.images?.namebanner)),
              _InformationMore(namecard: namecard),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageNamecard extends StatelessWidget {
  final String? linkImage;
  const _ImageNamecard({
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

class _ImageNamebanner extends StatelessWidget {
  final String? linkImage;
  const _ImageNamebanner({
    required this.linkImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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

class _InformationMore extends StatelessWidget {
  final Namecard namecard;
  const _InformationMore({required this.namecard});

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
              titleTranslate: "source", data: namecard.source),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: namecard.description),
        ],
      ),
    );
  }
}
