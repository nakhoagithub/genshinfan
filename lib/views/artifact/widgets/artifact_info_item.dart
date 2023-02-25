import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/resources/utils/theme.dart';
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
                  item: artifact.flower,
                  linkImage: artifact.images?.flower,
                ),
          artifact.plume == null
              ? const SizedBox()
              : _ArtifactItem(
                  item: artifact.plume,
                  linkImage: artifact.images?.plume,
                ),
          artifact.sands == null
              ? const SizedBox()
              : _ArtifactItem(
                  item: artifact.sands,
                  linkImage: artifact.images?.sands,
                ),
          artifact.goblet == null
              ? const SizedBox()
              : _ArtifactItem(
                  item: artifact.goblet,
                  linkImage: artifact.images?.goblet,
                ),
          _ArtifactItem(
            item: artifact.circlet,
            linkImage: artifact.images?.circlet,
          ),
        ],
      );
    });
  }
}

class _ArtifactItem extends StatelessWidget {
  final ArtifactItem? item;
  final String? linkImage;
  const _ArtifactItem({
    required this.item,
    required this.linkImage,
  });

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
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // image artifact
              Container(
                margin: const EdgeInsets.all(10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: linkImage ?? "",
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
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
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${item?.name}",
                      textAlign: TextAlign.center,
                      style: ThemeApp.textStyle(
                        fontSize: 18,
                        isDark: Get.isDarkMode,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${item?.relictype}",
                      textAlign: TextAlign.center,
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // description
          item?.description == null
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: Text(
                    "${item?.description}",
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
    );
  }
}
