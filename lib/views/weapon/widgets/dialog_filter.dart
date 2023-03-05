import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/checkbox_rarity.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

dialogFilterWeapon() async {
  CharacterController characterController = Get.find<CharacterController>();
  await Get.bottomSheet(
    isScrollControlled: true,
    Container(
      margin: const EdgeInsets.all(10),
      width: Get.mediaQuery.size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ThemeApp.colorCard(isDark: Get.isDarkMode)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "filter_weapon".tr,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SingleChildScrollView(
            child: Column(
              children: [
                _FilterElement(),
                _FilterWeapon(),
                _Rarity(),
                _SortName(),
              ],
            ),
          ),
          _Button(
            accept: () async {
              characterController.filter();
            },
            reset: () async {
              await dialogConfirm("confirm".tr, "reset_filter_comfirm".tr, () {
                characterController.reset();
              });
            },
          )
        ],
      ),
    ),
  );
}

class _FilterElement extends StatelessWidget {
  const _FilterElement();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "element".tr,
          style: ThemeApp.textStyle(isDark: Get.isDarkMode),
        ),
        SizedBox(
          height: 100,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Config.elements.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _ItemElement(
                  element: Config.elements[index],
                  index: index,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemElement extends StatelessWidget {
  final String element;
  final int index;
  const _ItemElement({required this.element, required this.index});

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Image.asset(Tools.getAssetElementFromName(element) ?? "",
              height: 30, width: 30),
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: Tools.getColorElementCharacter(element),
                value: characterController.checkElementFilters[index],
                onChanged: (value) async {
                  await characterController.checkElementFilter(index);
                });
          }, characterController.checkElementFilters),
        ],
      ),
    );
  }
}

class _FilterWeapon extends StatelessWidget {
  const _FilterWeapon();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "weapon".tr,
          style: ThemeApp.textStyle(isDark: Get.isDarkMode),
        ),
        SizedBox(
          height: 100,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Config.weapons.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _ItemWeapon(
                  weapon: Config.weapons[index],
                  index: index,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemWeapon extends StatelessWidget {
  final String weapon;
  final int index;
  const _ItemWeapon({required this.weapon, required this.index});

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Image.asset(Tools.getAssetWeaponType(weapon) ?? "",
              height: 30, width: 30),
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: characterController.checkWeaponFilters[index],
                onChanged: (value) async {
                  await characterController.checkWeaponFilter(index);
                });
          }, characterController.checkWeaponFilters),
        ],
      ),
    );
  }
}

class _Rarity extends StatelessWidget {
  const _Rarity();

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "rarity".tr,
          style: ThemeApp.textStyle(isDark: Get.isDarkMode),
        ),
        Row(
          children: [
            ObxValue((p0) {
              return Checkbox(
                  activeColor: ThemeApp.theme.primaryColor,
                  value: p0.value,
                  onChanged: (value) {
                    characterController.checkOneRarity();
                  });
            }, characterController.oneRarity),
            Text(
              "filter_with_rarity".tr,
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            )
          ],
        ),
        SizedBox(
          height: 50,
          child: Center(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _ItemRarity(
                  index: index,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemRarity extends StatelessWidget {
  final int index;
  const _ItemRarity({required this.index});

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    return ObxValue<RxList<bool>>((p0) {
      return CheckboxRarity(
        value: characterController.checkRarityFilters[index],
        onTap: () async {
          await characterController.checkRarityFilter(index);
        },
      );
    }, characterController.checkRarityFilters);
  }
}

class _SortName extends StatelessWidget {
  const _SortName();

  @override
  Widget build(BuildContext context) {
    CharacterController characterController = Get.find<CharacterController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ObxValue((p0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "sort_name".tr,
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile(
                  title: const Text("A -> Z"),
                  value: 0,
                  groupValue: p0.value,
                  onChanged: (value) {
                    characterController.checkSortFilter(value ?? 0);
                  }),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile(
                  title: const Text("Z -> A"),
                  value: 1,
                  groupValue: p0.value,
                  onChanged: (value) {
                    characterController.checkSortFilter(value ?? 1);
                  }),
            ),
          ],
        );
      }, characterController.sortName),
    );
  }
}

class _Button extends StatelessWidget {
  final Function accept;
  final Function reset;
  const _Button({
    required this.accept,
    required this.reset,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  await reset();
                  Get.back();
                },
                borderRadius: BorderRadius.circular(50),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("reset".tr),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 16,
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: ThemeApp.colorText(isDark: Get.isDarkMode),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(50),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("cancel".tr),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 16,
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: ThemeApp.colorText(isDark: Get.isDarkMode),
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await accept();
                  Get.back();
                },
                borderRadius: BorderRadius.circular(50),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("ok".tr),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
