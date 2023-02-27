import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/artifact/widgets/item_artifact.dart';
import 'package:get/get.dart';

dialogContributeArtifact(int type) async {
  await Get.bottomSheet(
    Container(
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      height: Get.height,
      width: Get.width,
      color: ThemeApp.colorScaffold(isDark: Get.isDarkMode),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(
            icon: Icons.keyboard_arrow_down_rounded,
          ),
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
              child: ItemArtifact(
                artifact: artifacts[index],
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
