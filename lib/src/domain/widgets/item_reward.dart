import 'package:flutter/material.dart';
import 'package:genshinfan/src/artifact/controllers/artifact_controller.dart';
import 'package:genshinfan/src/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:get/get.dart';

class ItemReward extends StatelessWidget {
  final Resource? resource;
  final Artifact? artifact;
  final String? rarity;
  final String name;
  final VoidCallback? onTap;
  final double? size;
  final bool noData;
  final String? contentIfNotImage;
  const ItemReward({
    super.key,
    this.resource,
    this.artifact,
    this.rarity,
    required this.name,
    this.onTap,
    this.size,
    this.noData = false,
    this.contentIfNotImage,
  });

  @override
  Widget build(BuildContext context) {
    String? rarity = artifact != null ? this.rarity : resource?.rarity;

    String? linkImage = resource != null
        ? Config.urlImage(resource!.images?.nameicon)
        : artifact != null
            ? Tool.linkImageArtifact(artifact!)
            : null;
    return InkWell(
      onTap: () {
        if (resource != null) {
          Get.find<ResourceController>().selectResource(resource!);
          Get.toNamed('/resource_info');
        } else if (artifact != null) {
          // xem thông tin thánh di vật
          Get.find<ArtifactController>().selectArtifact(artifact!);
          Get.toNamed('/artifact_info');
        }
      },
      child: ItemGame(
        size: size,
        title: name,
        rarity: rarity,
        linkImage: linkImage,
        contentIfNotImage: contentIfNotImage,
        star: resource != null ? true : null,
        onTap: onTap,
        noData: noData,
      ),
    );
  }
}
