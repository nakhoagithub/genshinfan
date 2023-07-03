import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/contribute/controllers/contribute_character_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/contribute/widgets/dialog_artifact.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

class ContributeItemArtifact extends StatelessWidget {
  final int type;
  const ContributeItemArtifact({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    double sizeItem = 94;
    return Container(
        margin: const EdgeInsets.all(20),
        child: Obx(
          () {
            Artifact? a1 = contributeCharacterController.a1.value;
            Artifact? a2 = contributeCharacterController.a2.value;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  child: InkWell(
                    onTap: () {
                      dialogContributeArtifact(type);
                    },
                    child: Container(
                      height: sizeItem * 1.215,
                      width: sizeItem,
                      decoration: BoxDecoration(
                        border: Border.all(
                            // color: ThemeApp.colorText(),
                            ),
                        borderRadius: BorderRadius.circular(sizeItem * 0.05),
                      ),
                      child: _ItemImage(type: type),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FadeInRight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCSS(
                          type == 0 ? a1?.set2 ?? "" : a2?.set2 ?? "",
                          style: ThemeApp.textStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        contributeCharacterController.type.value == 0
                            ? const SizedBox()
                            : FadeInRight(
                                child: TextCSS(
                                  a1?.set4 ?? "",
                                  style: ThemeApp.textStyle(fontSize: 15),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

class _ItemImage extends StatelessWidget {
  final int type;
  const _ItemImage({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();

    return Obx(() {
      Artifact? a1 = contributeCharacterController.a1.value;
      Artifact? a2 = contributeCharacterController.a2.value;
      return type == 0
          ? (a1 == null
              ? const Icon(Icons.add, size: 35)
              : ItemGame(
                  title: a1.name,
                  linkImage: Tools.linkImageArtifact(a1),
                  rarity: a1.rarity[a1.rarity.length - 1],
                  onTap: () {
                    dialogContributeArtifact(type);
                  },
                ))
          : (a2 == null
              ? const Icon(Icons.add, size: 35)
              : ItemGame(
                  title: a2.name,
                  linkImage: Tools.linkImageArtifact(a2),
                  rarity: a2.rarity[a2.rarity.length - 1],
                  onTap: () {
                    dialogContributeArtifact(type);
                  },
                ));
    });
  }
}
