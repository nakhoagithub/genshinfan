import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/artifact/widgets/artifact_info.dart';
import 'package:genshinfan/views/artifact/widgets/artifact_info_item.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
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
            ? PageEmpty(title: "choose_artifact".tr)
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: artifactController.scrollController,
                    child: const Column(
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
