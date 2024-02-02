import 'package:flutter/material.dart';
import 'package:genshinfan/src/character/controllers/character_controller.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.theme;
    return Container(padding: const EdgeInsets.all(4), child: const _List());
  }

  @override
  bool get wantKeepAlive => true;
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
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
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
