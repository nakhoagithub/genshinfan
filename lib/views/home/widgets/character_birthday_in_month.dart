import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/views/character/controllers/character_controller.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class ListCharacterBirthdayInMonth extends StatelessWidget {
  const ListCharacterBirthdayInMonth({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: Config.marginText,
        right: Config.marginText,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "birthday".tr,
            style: ThemeApp.textStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 160,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  _CharacterBirthdayToday(),
                  _CharacterBirthdayInMonth(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterBirthdayToday extends StatelessWidget {
  const _CharacterBirthdayToday();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "today".tr,
          style: ThemeApp.textStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        Expanded(
          child: Obx(() {
            List<Character> characterToday =
                homeController.characterBirthdayToday;
            List<Character> characters =
                homeController.characterBirthdayInMonth;
            return characterToday.isEmpty
                ? SizedBox(
                    width: 94,
                    child: Center(
                      child: Text(
                        "...",
                        style: ThemeApp.textStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: characterToday.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: SizedBox(
                          width: sizeItem,
                          height: sizeItem * 1.215,
                          child: ItemGame(
                            title: characterToday[index].name,
                            iconLeft: Tool.getAssetElementFromName(
                                        characters[index].element) !=
                                    ""
                                ? Image.asset(Tool.getAssetElementFromName(
                                    characterToday[index].element))
                                : null,
                            linkImage: characterToday[index].images?.icon,
                            rarity: characterToday[index].rarity.toString(),
                            onTap: () {
                              Get.find<CharacterController>()
                                  .selectCharacter(characterToday[index]);
                              Get.toNamed('/character_info');
                            },
                          ),
                          // child: ItemCharacter(
                          //   character: characterToday[index],
                          //   onTap: () {

                          //   },
                          // ),
                        ),
                      );
                    },
                  );
          }),
        ),
      ],
    );
  }
}

class _CharacterBirthdayInMonth extends StatelessWidget {
  const _CharacterBirthdayInMonth();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "birthday_in_month".tr,
          style: ThemeApp.textStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        Expanded(
          child: Obx(() {
            List<Character> characters =
                homeController.characterBirthdayInMonth;
            return ListView.builder(
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
            );
          }),
        ),
      ],
    );
  }
}
