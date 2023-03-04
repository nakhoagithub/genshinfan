import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/controllers/character_building_controller.dart';
import 'package:genshinfan/controllers/management_contribute_character_controller.dart';
import 'package:genshinfan/objects/app/character_building.dart';
import 'package:genshinfan/objects/app/user.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/services/artifact_service.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:genshinfan/views/artifact/widgets/item_artifact.dart';
import 'package:genshinfan/views/character/widgets/item_character.dart';
import 'package:genshinfan/views/weapon/widgets/item_weapon.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:genshinfan/views/widgets/wait.dart';
import 'package:get/get.dart';

class CharacterBuildingPage extends StatelessWidget {
  const CharacterBuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CharacterBuildingController());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        centerTitle: true,
        title: Text(
          "character_building".tr,
        ),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    CharacterBuildingController characterBuildingController =
        Get.find<CharacterBuildingController>();
    return Obx(() {
      int status = characterBuildingController.status.value;
      List<CharacterBuilding> characters =
          characterBuildingController.characters;
      return status == 1
          ? const WaitAMinute()
          : characters.isEmpty
              ? Center(
                  child: Text("contribute_manage_empty".tr),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      child: _Item(
                        characterBuilding: characters[index],
                        index: index,
                      ),
                    );
                  },
                );
    });
  }
}

class _Item extends StatelessWidget {
  final CharacterBuilding characterBuilding;
  final int index;
  const _Item({
    required this.characterBuilding,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    UserApp? user = Get.find<AppController>().userApp.value;
    int roleCurrentUser = user?.role ?? 10;
    String uidCurrentUser = user?.uid ?? "";
    Character? character =
        CharacterService().getCharacterFromId(characterBuilding.characterName);
    Weapon? weapon = WeaponService().getWeaponFromId(characterBuilding.weapon);
    Artifact? a1 = ArtifactService().getArtifactFromId(characterBuilding.a1);
    Artifact? a2 = ArtifactService().getArtifactFromId(characterBuilding.a2);

    List<String> chips = ['set2_artifact'.tr, 'set4_artifact'.tr];

    return Card(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  character == null
                      ? const SizedBox()
                      : ItemCharacter(character: character, onTap: () {}),
                  const SizedBox(width: 10),
                  weapon == null
                      ? const SizedBox()
                      : ItemWeapon(weapon: weapon, onTap: () {}),
                  const SizedBox(width: 10),
                  a1 == null
                      ? const SizedBox()
                      : ItemArtifact(artifact: a1, onTap: () {}),
                  const SizedBox(width: 10),
                  a2 == null
                      ? const SizedBox()
                      : ItemArtifact(artifact: a2, onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ChoiceChip(
              label: Text(
                chips[characterBuilding.typeSet],
              ),
              selected: true,
              onSelected: (value) {},
            ),
            // nguyên tố đối với nhà lữ hành
            characterBuilding.element == null || characterBuilding.element == ""
                ? const SizedBox()
                : Row(
                    children: [
                      Text(
                        "${"element".tr}: ",
                        style: ThemeApp.textStyle(isDark: Get.isDarkMode),
                      ),
                      Image.asset(
                          Tools.getAssetElementFromName(
                                  characterBuilding.element) ??
                              "",
                          height: 30,
                          width: 30),
                    ],
                  ),
            TextCSS(
              "${"sands_effect".tr}: <b>${characterBuilding.sands.tr}</b>",
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            ),
            TextCSS(
              "${"goblet_effect".tr}: <b>${characterBuilding.goblet.tr}</b>",
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            ),
            TextCSS(
              "${"circlet_effect".tr}: <b>${characterBuilding.circlet.tr}</b>",
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            ),
            const SizedBox(height: 20),
            TextCSS(
              "${"author".tr}: <b>${characterBuilding.author}</b>",
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            ),

            Config.roleAdminLV1.contains(roleCurrentUser) ||
                    uidCurrentUser == characterBuilding.uidAuthor
                ? _Browse(
                    characterBuilding: characterBuilding,
                    index: index,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class _Browse extends StatelessWidget {
  final CharacterBuilding characterBuilding;
  final int index;
  const _Browse({
    required this.characterBuilding,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    CharacterBuildingController characterBuildingController =
        Get.find<CharacterBuildingController>();
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () async {
            await dialogConfirm("delete".tr, "delete_contribute_to_database".tr,
                () async {
              await characterBuildingController.deleteContributionForManager(
                  characterBuilding, index);
            });
          },
          borderRadius: BorderRadius.circular(50),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text("delete".tr),
            ),
          ),
        ),
      ),
    );
  }
}