import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/contribute/widgets/dialog_character.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class SelectCharacter extends StatelessWidget {
  const SelectCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    double sizeItem = 94;
    return FadeInLeft(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              "character".tr,
              style: ThemeApp.textStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                dialogContributeCharacter();
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
                child: Obx(
                  () {
                    Character? c =
                        contributeCharacterController.character.value;
                    return c == null
                        ? const Icon(Icons.add, size: 35)
                        : ItemGame(
                            title: c.name,
                            iconLeft:
                                Tools.getAssetElementFromName(c.elementType) !=
                                        ""
                                    ? Image.asset(Tools.getAssetElementFromName(
                                        c.elementType))
                                    : null,
                            linkImage: c.images?.mihoyoIcon,
                            rarity: c.rarity.toString(),
                            onTap: () {
                              dialogContributeCharacter();
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
