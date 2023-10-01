import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/character/controllers/character_controller.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class ListCharacter extends StatelessWidget {
  final List<Character> characters;
  const ListCharacter({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return characters.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "character".tr,
                      style: ThemeApp.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 140,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      // physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SizedBox(
                            width: sizeItem,
                            height: sizeItem * 1.215,
                            child: ItemGame(
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
                                Get.find<CharacterController>()
                                    .selectCharacter(characters[index]);
                                Get.toNamed('/character_info');
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
