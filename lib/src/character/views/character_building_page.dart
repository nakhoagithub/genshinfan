import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/role.dart';
import 'package:genshinfan/src/character/controllers/character_building_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/services/artifact_service.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:genshinfan/src/user_manager/widgets/image_user.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/dialog.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/text_css.dart';
import 'package:genshinfan/src/widgets/wait.dart';
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        int status = characterBuildingController.status.value;
        List<CharacterBuilding> characters =
            characterBuildingController.charactersBuilding;
        return status == 1
            ? const WaitAMinute()
            : characters.isEmpty
                ? Center(
                    child: Text("contribute_manage_empty".tr),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
      }),
    );
  }
}

class _InfoAuthor extends StatelessWidget {
  final CharacterBuilding characterBuilding;
  final int index;
  const _InfoAuthor({required this.characterBuilding, required this.index});

  @override
  Widget build(BuildContext context) {
    CharacterBuildingController characterBuildingController =
        Get.find<CharacterBuildingController>();
    User? user = Get.find<MainController>().user.value;
    String uidCurrentUser = user?.uid ?? "";

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        children: [
          ImageUser(linkImage: characterBuilding.userAuthor?.linkImage),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              characterBuilding.author,
              style: ThemeApp.textStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Role.isRoleAdmin() || uidCurrentUser == characterBuilding.uidAuthor
              ? IconButton(
                  onPressed: () async {
                    await dialogConfirm(
                        "delete".tr, "delete_contribute_to_database".tr,
                        () async {
                      await characterBuildingController.deleteContribution(
                          characterBuilding, index);
                    });
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
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
    Character? character =
        CharacterService().getCharacterFromId(characterBuilding.characterName);
    Weapon? weapon = WeaponService().getWeaponFromId(characterBuilding.weapon);
    Artifact? a1 = ArtifactService().getArtifactFromKey(characterBuilding.a1);
    Artifact? a2 = ArtifactService().getArtifactFromKey(characterBuilding.a2);

    List<String> chips = ['set2_artifact'.tr, 'set4_artifact'.tr];

    return Card(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoAuthor(characterBuilding: characterBuilding, index: index),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  character == null
                      ? const SizedBox()
                      : ItemGame(
                          title: character.name,
                          iconLeft:
                              Tool.getAssetElementFromName(character.element) !=
                                      ""
                                  ? Image.asset(Tool.getAssetElementFromName(
                                      character.element))
                                  : null,
                          linkImage: character.images?.icon,
                          rarity: character.rarity.toString(),
                          onTap: () {}),
                  // : ItemCharacter(character: character, onTap: () {}),
                  const SizedBox(width: 10),
                  weapon == null
                      ? const SizedBox()
                      : ItemGame(
                          title: weapon.name,
                          iconLeft:
                              Tool.getAssetWeaponType(weapon.weapontype) != null
                                  ? Image.asset(Tool.getAssetWeaponType(
                                          weapon.weapontype) ??
                                      "")
                                  : null,
                          linkImage: weapon.images?.icon ??
                              Config.urlImage(weapon.images?.namegacha),
                          rarity: weapon.rarity.toString(),
                          star: true,
                          onTap: () {}),
                  const SizedBox(width: 10),
                  a1 == null
                      ? const SizedBox()
                      : ItemGame(
                          title: a1.name,
                          linkImage: Tool.linkImageArtifact(a1),
                          rarity: a1.rarity[a1.rarity.length - 1],
                          onTap: () {}),
                  const SizedBox(width: 10),
                  a2 == null
                      ? const SizedBox()
                      : ItemGame(
                          title: a2.name,
                          linkImage: Tool.linkImageArtifact(a2),
                          rarity: a2.rarity[a2.rarity.length - 1],
                          onTap: () {}),
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
                        style: ThemeApp.textStyle(),
                      ),
                      Image.asset(
                          Tool.getAssetElementFromName(
                              characterBuilding.element),
                          height: 30,
                          width: 30),
                    ],
                  ),

            /// version 1.5
            TextCSS(
              "${"sands_effect".tr}: <b>${Tool.listToString(characterBuilding.sands)}</b>",
              style: ThemeApp.textStyle(),
            ),
            TextCSS(
              "${"goblet_effect".tr}: <b>${Tool.listToString(characterBuilding.goblets)}</b>",
              style: ThemeApp.textStyle(),
            ),
            TextCSS(
              "${"circlet_effect".tr}: <b>${Tool.listToString(characterBuilding.circlets)}</b>",
              style: ThemeApp.textStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
