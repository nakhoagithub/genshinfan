import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/views/character/widgets/item_character.dart';
import 'package:get/get.dart';

import '../../resources/widgets/app_bar.dart';

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
            onTapAction: () {},
          ),
          const Expanded(child: _ListCharacter()),
        ],
      ),
    );
  }
}

class _ListCharacter extends StatelessWidget {
  const _ListCharacter();

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    double sizeItem = 94;
    return LayoutBuilder(builder: (p0, p1) {
      double w = p1.maxWidth;
      return GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: w >= 300 ? 3 : 2,
        childAspectRatio: sizeItem / (sizeItem * 1.215),
        children: List.generate(
          characterController.characters.length,
          (index) => FadeInUp(
            child: Center(
              child: SizedBox(
                width: sizeItem,
                height: sizeItem * 1.215,
                child: ItemCharacter(
                  character: characterController.characters[index],
                  onTap: () {
                    CharacterController characterController =
                        Get.find<CharacterController>();
                    characterController.selectCharacter(characterController.characters[index]);
                    HomeController homeController = Get.find<HomeController>();
                    homeController.pageCenter();
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
