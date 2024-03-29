import 'package:flutter/material.dart';
import 'package:genshinfan/src/artifact/controllers/artifact_controller.dart';
import 'package:genshinfan/src/artifact/widgets/artifact_info.dart';
import 'package:genshinfan/src/artifact/widgets/artifact_info_item.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class ArtifactInfoPage extends StatelessWidget {
  const ArtifactInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ArtifactController artifactController = Get.find<ArtifactController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "artifact_information".tr,
            // style: ApplicationManager.textStyle(
            //   isDark: settingState.isDark,
            // ),
          ),
        ),
        body: artifactController.artifact.value == null
            ? PageEmpty(title: "select_artifact".tr)
            : const Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationArtifact(),
                        InformationItemArtifact(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
