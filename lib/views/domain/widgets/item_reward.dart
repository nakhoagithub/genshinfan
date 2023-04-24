import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class ItemReward extends StatelessWidget {
  final Resource? resource;
  final Artifact? artifact;
  final String? rarity;
  final String name;
  final VoidCallback onTap;
  const ItemReward({
    super.key,
    required this.resource,
    required this.artifact,
    this.rarity,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String? rarity = artifact != null ? this.rarity : resource?.rarity;

    String? linkImage = resource != null
        ? Config.urlImage(resource!.images?.nameicon)
        : artifact != null
            ? Tools.linkImageArtifact(artifact!)
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
          title: name,
          rarity: rarity,
          linkImage: linkImage,
          star: resource != null ? true : null,
          onTap: onTap),
    );
  }
}
