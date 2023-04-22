import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/talent.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/icon_app.dart';
import 'package:genshinfan/views/character/widgets/talent_stat.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:genshinfan/views/widgets/title_of_content.dart';
import 'package:get/get.dart';
import 'skill_ascension.dart';

class SkillCharacterView extends StatelessWidget {
  const SkillCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CharacterController characterController = Get.find<CharacterController>();
    return Obx(() {
      String association = characterController.character.value!.association;
      List<Talent>? talentTravelers =
          characterController.character.value!.talentTravelers;
      List<Constellations>? constellationTravelers =
          characterController.character.value!.constellationTravelers;
      return Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // title
            TitleOfContent(title: "skill".tr),

            // content
            association == "MAINACTOR" &&
                    talentTravelers != null &&
                    constellationTravelers != null
                ? _SkillViewAndConstellationTraveler(
                    talents:
                        characterController.character.value!.talentTravelers!,
                    constellations: characterController
                        .character.value!.constellationTravelers!,
                  )
                : _SkillViewAndConstellation(
                    talent: characterController.character.value!.talent,
                    constellations:
                        characterController.character.value!.constellations,
                    element: characterController.character.value!.element,
                  ),
          ],
        ),
      );
    });
  }
}

class _SkillViewAndConstellation extends StatelessWidget {
  final Talent? talent;
  final Constellations? constellations;
  final String? element;
  const _SkillViewAndConstellation({
    required this.talent,
    required this.constellations,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return talent == null
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // tấn công thường
              _Combat(
                combat: talent!.combat1,
                imageTalent: talent?.imageTalent?.combat1,
                element: element,
              ),
              // E
              _Combat(
                combat: talent!.combat2,
                imageTalent: talent?.imageTalent?.combat2,
                element: element,
              ),
              // Q
              _Combat(
                combat: talent!.combat3,
                imageTalent: talent?.imageTalent?.combat3,
                element: element,
              ),
              // sp
              talent!.combatsp == null
                  ? const SizedBox()
                  : _Combat(
                      combat: talent!.combatsp!,
                      imageTalent: talent?.imageTalent?.combatsp,
                      element: element,
                    ),

              // nguyên liệu nâng cấp kỹ năng
              SkillAscensionView(
                costs: talent!.costs,
                element: element,
              ),

              TitleOfContent(
                title: "skill_passive".tr,
              ),

              _Passive(
                passive: talent!.passive1,
                imageTalent: talent?.imageTalent?.passive1,
                element: element,
              ),

              _Passive(
                passive: talent!.passive2,
                imageTalent: talent?.imageTalent?.passive2,
                element: element,
              ),

              talent!.passive3 == null
                  ? const SizedBox()
                  : _Passive(
                      passive: talent!.passive3!,
                      imageTalent: talent?.imageTalent?.passive3,
                      element: element,
                    ),

              TitleOfContent(
                title: "constellation".tr,
              ),

              constellations == null
                  ? const SizedBox()
                  : Column(
                      children: [
                        _Constellation(
                          lv: "1",
                          constellation: constellations!.c1,
                          imageConstellation:
                              constellations!.imageConstellation?.c1,
                          element: element,
                        ),
                        _Constellation(
                          lv: "2",
                          constellation: constellations!.c2,
                          imageConstellation:
                              constellations!.imageConstellation?.c2,
                          element: element,
                        ),
                        _Constellation(
                          lv: "3",
                          constellation: constellations!.c3,
                          imageConstellation:
                              constellations!.imageConstellation?.c3,
                          element: element,
                        ),
                        _Constellation(
                          lv: "4",
                          constellation: constellations!.c4,
                          imageConstellation:
                              constellations!.imageConstellation?.c4,
                          element: element,
                        ),
                        _Constellation(
                          lv: "5",
                          constellation: constellations!.c5,
                          imageConstellation:
                              constellations!.imageConstellation?.c5,
                          element: element,
                        ),
                        _Constellation(
                          lv: "6",
                          constellation: constellations!.c6,
                          imageConstellation:
                              constellations!.imageConstellation?.c6,
                          element: element,
                        ),
                      ],
                    ),
            ],
          );
  }
}

class _SkillViewAndConstellationTraveler extends StatelessWidget {
  final List<Talent> talents;
  final List<Constellations> constellations;
  const _SkillViewAndConstellationTraveler({
    required this.talents,
    required this.constellations,
  });

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    Rx<int> selected = 0.obs;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: ObxValue(
            (data) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...talents.asMap().entries.map(
                  (e) {
                    return _SelectElementTraveler(
                      element: e.value.element,
                      select: data.value == e.key,
                      onTap: () {
                        data.value = e.key;
                        selected.value = e.key;
                        characterController.selectElement(e.value.element);
                      },
                    );
                  },
                )
              ],
            ),
            selected,
          ),
        ),
        ObxValue(
          (data) => _SkillViewAndConstellation(
            talent: talents[data.value],
            constellations: constellations[data.value],
            element: talents[data.value].element,
          ),
          selected,
        ),
      ],
    );
  }
}

class _SelectElementTraveler extends StatelessWidget {
  final String? element;
  final bool? select;
  final VoidCallback onTap;
  const _SelectElementTraveler({
    required this.element,
    required this.select,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                select == true ? Get.theme.colorScheme.onInverseSurface : null,
          ),
          child: Image.asset(
            Tools.getAssetElementFromName(element),
            height: 40,
            width: 40,
          ),
        ),
      ),
    );
  }
}

class _Combat extends StatelessWidget {
  final Combat combat;
  final String? imageTalent;
  final String? element;
  const _Combat({
    required this.combat,
    required this.imageTalent,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          strokeAlign: 1,
          // color: ThemeApp.colorText(isDark: Get.isDarkMode),
        ),
        // color: Tools.getColorElementCharacter(element).withOpacity(0.5),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image skill
                Container(
                  margin: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Tools.getColorElementCharacter(element)
                        .withOpacity(0.5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        imageTalent == null ? "" : Config.urlImage(imageTalent),
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const Center(
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.black54,
                          size: 20,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    combat.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      fontSize: 18,
                      isDark: Get.isDarkMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: IconApp(
                      onTap: () {
                        Get.bottomSheet(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          TalentStats(combat: combat),
                          isScrollControlled: true,
                        );
                      },
                      icon: const Icon(Icons.expand_more_rounded)),
                ),
              ],
            ),
            // description
            combat.description == null
                ? const SizedBox()
                : Container(
                    margin:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    child: Text(
                      "${combat.description}",
                      textAlign: TextAlign.start,
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

            // info
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: TextCSS(
                combat.info,
                textAlign: TextAlign.start,
                style: ThemeApp.textStyle(
                  isDark: Get.isDarkMode,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Passive extends StatelessWidget {
  final Passive passive;
  final String? imageTalent;
  final String? element;
  const _Passive({
    required this.passive,
    required this.imageTalent,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          strokeAlign: 1,
          // color: ThemeApp.colorText(isDark: Get.isDarkMode),
        ),
        // color: Tools.getColorElementCharacter(element).withOpacity(0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Tools.getColorElementCharacter(element).withOpacity(0.5),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageTalent == null
                      ? ""
                      : "https://res.cloudinary.com/genshin/image/upload/sprites/$imageTalent.png",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                  progressIndicatorBuilder: (context, url, progress) {
                    return const Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.black54,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Text(
                  passive.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 18,
                    isDark: Get.isDarkMode,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // info
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: TextCSS(
              passive.info,
              textAlign: TextAlign.start,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Constellation extends StatelessWidget {
  final String lv;
  final Constellation constellation;
  final String? imageConstellation;
  final String? element;
  const _Constellation({
    required this.lv,
    required this.constellation,
    required this.imageConstellation,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          strokeAlign: 1,
          // color: ThemeApp.colorText(isDark: Get.isDarkMode),
        ),
        // color: Tools.getColorElementCharacter(element).withOpacity(0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  lv,
                  style: ThemeApp.textStyle(
                      isDark: Get.isDarkMode,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 5, right: 10, top: 10, bottom: 10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Tools.getColorElementCharacter(element).withOpacity(0.5),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      imageConstellation == null ? "" : "$imageConstellation",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                  progressIndicatorBuilder: (context, url, progress) {
                    return const Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.black54,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Text(
                  constellation.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 18,
                    isDark: Get.isDarkMode,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // info
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: TextCSS(
              constellation.effect,
              textAlign: TextAlign.start,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
