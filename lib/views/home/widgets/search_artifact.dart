import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/artifact/controllers/artifact_controller.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class ListArtifact extends StatelessWidget {
  final List<Artifact> artifacts;
  const ListArtifact({super.key, required this.artifacts});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return artifacts.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "artifact".tr,
                      style: ThemeApp.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: artifacts.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SizedBox(
                            width: sizeItem,
                            height: sizeItem * 1.215,
                            child: ItemGame(
                              title: artifacts[index].name,
                              linkImage:
                                  Tool.linkImageArtifact(artifacts[index]),
                              rarity: artifacts[index]
                                  .rarity[artifacts[index].rarity.length - 1],
                              onTap: () {
                                Get.find<ArtifactController>()
                                    .selectArtifact(artifacts[index]);
                                Get.toNamed("/artifact_info");
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
