import 'package:flutter/material.dart';
import 'package:genshinfan/src/artifact/controllers/artifact_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class ArtifactPage extends StatefulWidget {
  const ArtifactPage({super.key});

  @override
  State<ArtifactPage> createState() => _ArtifactPageState();
}

class _ArtifactPageState extends State<ArtifactPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("artifact".tr),
      ),
      body: const _List(),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
          : Obx(() => GridView.count(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount:
                    Get.find<LayoutController>().crossAxisCount.value,
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
              ));
    });
  }
}
