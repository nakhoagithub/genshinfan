import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/views/character/controllers/character_controller.dart';
import 'package:genshinfan/views/character/widgets/character_stats.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';
import '../widgets/character_ascension.dart';
import '../widgets/character_info.dart';
import '../widgets/character_skill.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CharacterController characterController = Get.find<CharacterController>();
    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: Text(
            "character_information".tr,
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (characterController.character.value != null) {
                  Get.toNamed("/character_building");
                } else {
                  Fluttertoast.showToast(msg: "select_character".tr);
                }
              },
              icon: const Icon(Icons.keyboard_arrow_right_rounded),
            )
          ],
        ),
        body: characterController.character.value == null
            ? PageEmpty(title: "select_character".tr)
            : Stack(
                children: [
                  SizedBox(
                    width: context.mediaQuerySize.width,
                    height: context.mediaQuerySize.height,
                    child: Opacity(
                      opacity: 0.3,
                      child: CachedNetworkImage(
                        imageUrl: characterController
                                .character.value?.images?.cover2 ??
                            "",
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: LinearProgressIndicator(
                              value: progress.progress,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    controller: characterController.scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: const Column(
                      children: [
                        InformationCharacter(),
                        SkillCharacterView(),
                        CharacterAscensionView(),
                        CharacterStats(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
