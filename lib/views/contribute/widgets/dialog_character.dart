import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/tools.dart';

import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

dialogContributeCharacter() async {
  await Get.bottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    SizedBox(
      height: Get.height * 0.9,
      width: Get.width,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(
            icon: Icons.keyboard_arrow_down_rounded,
          ),
          title: Text("character".tr),
        ),
        body: const _ListCharacter(),
      ),
    ),
    isScrollControlled: true,
  );
}

class _ListCharacter extends StatelessWidget {
  const _ListCharacter();

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    List<Character> characters = contributeCharacterController.characters;
    double sizeItem = 94;
    return GridView.count(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: Get.width >= 400 ? 4 : 3,
      childAspectRatio: sizeItem / (sizeItem * 1.215),
      children: List.generate(
        characters.length,
        (index) => FadeInUp(
          child: Center(
            child: SizedBox(
              width: sizeItem,
              height: sizeItem * 1.215,
              child: ItemGame(
                  title: characters[index].name,
                  iconLeft: Tools.getAssetElementFromName(
                              characters[index].element) !=
                          ""
                      ? Image.asset(Tools.getAssetElementFromName(
                          characters[index].element))
                      : null,
                  linkImage: characters[index].images?.icon,
                  rarity: characters[index].rarity.toString(),
                  onTap: () {
                    Get.find<ContributeCharacterController>()
                        .selectCharacter(characters[index]);
                    Get.back();
                  }),
              // child: ItemCharacter(
              //   character: characters[index],
              //   onTap: () {
              //     Get.find<ContributeCharacterController>()
              //         .selectCharacter(characters[index]);
              //     Get.back();
              //   },
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
