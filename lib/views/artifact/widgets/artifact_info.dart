import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/info_multi_rarity_widget.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:get/get.dart';

class InformationArtifact extends StatelessWidget {
  const InformationArtifact({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ArtifactController artifactController = Get.find<ArtifactController>();
    return Obx(() {
      Artifact artifact = artifactController.artifact.value!;
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
                    artifact.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      isDark: Get.isDarkMode,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _InformationMore(
                artifact: artifact,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _InformationMore extends StatelessWidget {
  final Artifact artifact;
  const _InformationMore({required this.artifact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Độ hiếm
          InfoMultiRarityWidget(rarities: artifact.rarity),

          // kích hoạt set 1
          artifact.set1 == null
              ? const SizedBox()
              : InfoParagraphWidget(
                  titleTranslate: "set1", data: artifact.set1 ?? ""),

          // kích hoạt set 2
          artifact.set2 == null
              ? const SizedBox()
              : InfoParagraphWidget(
                  titleTranslate: "set2", data: artifact.set2 ?? ""),

          // kích hoạt set 4
          artifact.set4 == null
              ? const SizedBox()
              : InfoParagraphWidget(
                  titleTranslate: "set4", data: artifact.set4 ?? ""),
        ],
      ),
    );
  }
}
