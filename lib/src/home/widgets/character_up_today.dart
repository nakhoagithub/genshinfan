import 'package:flutter/material.dart';
import 'package:genshinfan/src/character/controllers/character_controller.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/home/controllers/home_controller.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/dialog.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:get/get.dart';

class ListCharacterUpToday extends StatelessWidget {
  const ListCharacterUpToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    HomeController homeController = Get.find<HomeController>();
    return Obx(() {
      List<Character> characterUpToday = homeController.characterUpToday;
      return characterUpToday.isEmpty
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
                        itemCount: characterUpToday.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: SizedBox(
                              width: sizeItem,
                              height: sizeItem * 1.215,
                              child: ItemGame(
                                title: characterUpToday[index].name,
                                iconLeft: Tool.getAssetElementFromName(
                                            characterUpToday[index].element) !=
                                        ""
                                    ? Image.asset(Tool.getAssetElementFromName(
                                        characterUpToday[index].element))
                                    : null,
                                linkImage: characterUpToday[index].images?.icon,
                                rarity:
                                    characterUpToday[index].rarity.toString(),
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
    });
  }
}
