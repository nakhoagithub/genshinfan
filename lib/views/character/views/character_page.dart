import 'package:flutter/material.dart';
import 'package:genshinfan/app_layout.dart';
import 'package:genshinfan/views/character/controllers/character_controller.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    return Obx(() {
      List<Character> characters = characterController.charactersView;
      return characters.isEmpty
          ? ListEmpty(title: "empty_character".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<AppLayoutController>().crossAxisCount(),
              childAspectRatio:
                  Get.find<AppLayoutController>().childAspectRatio(),
              children: List.generate(
                characters.length,
                (index) {
                  return ItemGame(
                      title: characters[index].name,
                      iconLeft: Tool.getAssetElementFromName(
                                  characters[index].element) !=
                              ""
                          ? Image.asset(Tool.getAssetElementFromName(
                              characters[index].element))
                          : null,
                      linkImage: characters[index].images?.icon,
                      rarity: characters[index].rarity.toString(),
                      onTap: () {
                        characterController.selectCharacter(characters[index]);
                        Get.toNamed("/character_info");
                      });
                },
              ),
            );
    });
  }
}
