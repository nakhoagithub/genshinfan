import 'package:flutter/material.dart';
import 'package:genshinfan/views/artifact/controllers/artifact_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class ArtifactPage extends StatelessWidget {
  const ArtifactPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    ArtifactController artifactController = Get.find<ArtifactController>();
    return Obx(() {
      List<Artifact> artifacts = artifactController.artifacts;
      return artifacts.isEmpty
          ? ListEmpty(title: "empty_artifact".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                artifacts.length,
                (index) => ItemGame(
                  title: artifacts[index].name,
                  linkImage: Tool.linkImageArtifact(artifacts[index]),
                  rarity: artifacts[index]
                      .rarity[artifacts[index].rarity.length - 1],
                  onTap: () {
                    artifactController.selectArtifact(artifacts[index]);
                    Get.toNamed("/artifact_info");
                  },
                ),
              ),
            );
    });
  }
}
