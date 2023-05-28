import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class ListCharacterUpToday extends StatelessWidget {
  const ListCharacterUpToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Config.sizeItem3;
    List<Character>? characterUpToday =
        CharacterService().getCharacterUpToday();
    return characterUpToday == null
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
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: InkWell(
                        onTap: () async {
                          dialogInfo("character_up_today".tr);
                        },
                        child: const Icon(
                          Icons.help_outline_rounded,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      // physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: characterUpToday.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SizedBox(
                            width: sizeItem,
                            height: sizeItem * 1.215,
                            child: ItemGame(
                              title: characterUpToday[index].name,
                              iconLeft: Tools.getAssetElementFromName(
                                          characterUpToday[index].element) !=
                                      ""
                                  ? Image.asset(Tools.getAssetElementFromName(
                                      characterUpToday[index].element))
                                  : null,
                              linkImage: characterUpToday[index].images?.icon,
                              rarity: characterUpToday[index].rarity.toString(),
                              onTap: () {
                                Get.find<CharacterController>()
                                    .selectCharacter(characterUpToday[index]);
                                Get.toNamed('/character_info');
                              },
                            ),
                            // child: ItemCharacter(
                            //   character: characterUpToday[index],
                            //   onTap: () {
                            //     Get.find<CharacterController>()
                            //         .selectCharacter(characterUpToday[index]);
                            //     Get.toNamed('/character_info');
                            //   },
                            // ),
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
