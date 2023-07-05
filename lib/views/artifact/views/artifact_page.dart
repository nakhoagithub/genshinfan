import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/artifact/controllers/artifact_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class ArtifactPage extends StatelessWidget {
  const ArtifactPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "artifact".tr,
            width: double.infinity,
          ),
          const Expanded(
            child: _List(),
          )
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    ArtifactController artifactController = Get.find<ArtifactController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Artifact> artifacts = artifactController.artifacts;
      return SizedBox(
          width: Config.widthCenter,
          child: artifacts.isEmpty
              ? ListEmpty(title: "empty_artifact".tr)
              : GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  childAspectRatio: sizeItem / (sizeItem * 1.215),
                  children: List.generate(
                    artifacts.length,
                    (index) => FadeInUp(
                      child: Center(
                        child: SizedBox(
                          width: sizeItem,
                          height: sizeItem * 1.215,
                          child: ItemGame(
                            title: artifacts[index].name,
                            linkImage: Tool.linkImageArtifact(artifacts[index]),
                            rarity: artifacts[index]
                                .rarity[artifacts[index].rarity.length - 1],
                            onTap: () {
                              artifactController
                                  .selectArtifact(artifacts[index]);
                              homeController.pageCenter();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}
