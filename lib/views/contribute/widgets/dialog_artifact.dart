import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/contribute/controllers/contribute_character_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/tools.dart';

import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

dialogContributeArtifact(int type) async {
  await Get.bottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    SizedBox(
      height: Get.height * 0.9,
      width: Get.width,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text("artifact".tr),
        ),
        body: _List(type: type),
      ),
    ),
    isScrollControlled: true,
  );
}

class _List extends StatelessWidget {
  final int type;
  const _List({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    List<Artifact> artifacts = contributeCharacterController.artifacts;
    double sizeItem = 94;
    return GridView.count(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: Get.width >= 400 ? 4 : 3,
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
                rarity:
                    artifacts[index].rarity[artifacts[index].rarity.length - 1],
                onTap: () {
                  if (type == 0) {
                    Get.find<ContributeCharacterController>()
                        .selectA1(artifacts[index]);
                  } else {
                    Get.find<ContributeCharacterController>()
                        .selectA2(artifacts[index]);
                  }
                  Get.back();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
