import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/views/character/widgets/dialog_filter.dart';
import 'package:genshinfan/views/character/widgets/item_character.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "character".tr,
            width: double.infinity,
            actions: [
              IconButton(
                onPressed: () {
                  dialogFilterCharacter();
                },
                icon: const Icon(Icons.filter_alt_rounded),
              )
            ],
          ),
          const Expanded(child: _List()),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Character> characters = characterController.characters;
      return SizedBox(
          width: Config.widthCenter,
          child: characters.isEmpty
              ? ListEmpty(title: "empty_character".tr)
              : GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  childAspectRatio: sizeItem / (sizeItem * 1.215),
                  children: List.generate(
                    characters.length,
                    (index) => FadeInUp(
                      child: Center(
                        child: SizedBox(
                          width: sizeItem,
                          height: sizeItem * 1.215,
                          child: ItemCharacter(
                            character: characters[index],
                            onTap: () {
                              characterController
                                  .selectCharacter(characters[index]);
                              homeController.pageCenter();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}