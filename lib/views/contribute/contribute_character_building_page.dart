import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/contribute/widgets/button_contribute.dart';
import 'package:genshinfan/views/contribute/widgets/select_character.dart';
import 'package:genshinfan/views/contribute/widgets/select_circlet.dart';
import 'package:genshinfan/views/contribute/widgets/select_goblet.dart';
import 'package:genshinfan/views/contribute/widgets/select_item_artifact.dart';
import 'package:genshinfan/views/contribute/widgets/select_sands.dart';
import 'package:genshinfan/views/contribute/widgets/select_type.dart';
import 'package:genshinfan/views/contribute/widgets/select_weapon.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

class ContributeCharacterBuildingPage extends StatelessWidget {
  const ContributeCharacterBuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    Get.put(ContributeCharacterController());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("contribute".tr),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Author(),
            _SelectCharacterAndWeapon(),
            _SelectElementCharacter(),
            SelectTypeSet(),
            _SelectArtifact(),
            SelectSandsEffect(),
            SelectGobletEffect(),
            SelectCircletEffect(),
            _Note(),
            ButtonContributeCharacter(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _Author extends StatelessWidget {
  const _Author();

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find<AppController>();
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();

    contributeCharacterController.author.value =
        appController.userApp.value?.name ?? "";
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextFormField(
        autofocus: false,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value != null) {
            return value.length >= 3 ? null : "invalid".tr;
          }
          return null;
        },
        initialValue: appController.userApp.value?.name ?? "",
        onChanged: (value) {
          contributeCharacterController.changeAuthor(value);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "author".tr,
          label: Text(
            "author".tr,
            style: ThemeApp.textStyle(isDark: Get.isDarkMode),
          ),
        ),
        maxLength: 30,
      ),
    );
  }
}

class _SelectCharacterAndWeapon extends StatelessWidget {
  const _SelectCharacterAndWeapon();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectCharacter(),
        SizedBox(width: 20),
        SelectWeapon(),
      ],
    );
  }
}

class _SelectElementCharacter extends StatelessWidget {
  const _SelectElementCharacter();

  @override
  Widget build(BuildContext context) {
    RxInt selected = 0.obs;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    return Obx(() {
      Character? character =
          Get.find<ContributeCharacterController>().character.value;
      contributeCharacterController.elementOfTraveler.value =
          character?.talentTravelers?[0].element ?? "";
      return character == null || character.talentTravelers == null
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.only(top: 10),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ObxValue(
                    (data) => Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...character.talentTravelers!.asMap().entries.map(
                          (e) {
                            return _SelectElementTraveler(
                              element: e.value.element,
                              select: data.value == e.key,
                              onTap: () {
                                data.value = e.key;
                                contributeCharacterController.elementOfTraveler
                                    .value = e.value.element ?? "";
                              },
                            );
                          },
                        )
                      ],
                    ),
                    selected,
                  ),
                ),
              ),
            );
    });
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
            color: select == true
                ? ThemeApp.colorText(isDark: Get.isDarkMode).withOpacity(0.2)
                : null,
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

class _SelectArtifact extends StatelessWidget {
  const _SelectArtifact();

  @override
  Widget build(BuildContext context) {
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            "artifact".tr,
            style: ThemeApp.textStyle(
              isDark: Get.isDarkMode,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(
            () => Column(
              children: [
                const ContributeItemArtifact(type: 0),
                contributeCharacterController.type.value == 1
                    ? const SizedBox()
                    : const ContributeItemArtifact(type: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextCSS(
        "<b><red>${"note".tr}:</red></b> ${"note_contribute_character_building".tr}",
        style: ThemeApp.textStyle(isDark: Get.isDarkMode),
      ),
    );
  }
}
