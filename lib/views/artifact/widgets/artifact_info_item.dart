import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/artifact/widgets/item_artifact.dart';
import 'package:get/get.dart';

class InformationItemArtifact extends StatelessWidget {
  const InformationItemArtifact({super.key});

  @override
  Widget build(BuildContext context) {
    ArtifactController artifactController = Get.find<ArtifactController>();
    return Obx(() {
      Artifact artifact = artifactController.artifact.value!;
      return Column(
        children: [
          // item artifact
          artifact.flower == null
              ? const SizedBox()
              : _ArtifactItem(
                  artifact: artifact,
                  type: 1,
                  linkImage: artifact.images?.flower,
                ),
          artifact.plume == null
              ? const SizedBox()
              : _ArtifactItem(
                  artifact: artifact,
                  type: 2,
                  linkImage: artifact.images?.plume,
                ),
          artifact.sands == null
              ? const SizedBox()
              : _ArtifactItem(
                  artifact: artifact,
                  type: 3,
                  linkImage: artifact.images?.sands,
                ),
          artifact.goblet == null
              ? const SizedBox()
              : _ArtifactItem(
                  artifact: artifact,
                  type: 4,
                  linkImage: artifact.images?.goblet,
                ),
          _ArtifactItem(
            artifact: artifact,
            type: 5,
            linkImage: artifact.images?.circlet,
          ),
        ],
      );
    });
  }
}

class _ArtifactItem extends StatelessWidget {
  final Artifact artifact;
  final int type;
  final String? linkImage;
  const _ArtifactItem({
    required this.artifact,
    required this.type,
    required this.linkImage,
  });

  ArtifactItem? artifactItemWithType() {
    switch (type) {
      case 1:
        return artifact.flower;
      case 2:
        return artifact.plume;
      case 3:
        return artifact.sands;
      case 4:
        return artifact.goblet;
      case 5:
        return artifact.circlet;
    }
    return artifact.flower ?? artifact.circlet;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          strokeAlign: 1,
          color: ThemeApp.colorText(isDark: Get.isDarkMode),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              child: ItemArtifact(
                artifact: artifact,
                onTap: () {},
                viewType: type,
              )),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${artifactItemWithType()?.name}",
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 18,
                    isDark: Get.isDarkMode,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${artifactItemWithType()?.relictype}",
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                  ),
                ),
                // description
                artifactItemWithType()?.description == null
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: Text(
                          "${artifactItemWithType()?.description}",
                          textAlign: TextAlign.start,
                          style: ThemeApp.textStyle(
                            isDark: Get.isDarkMode,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
