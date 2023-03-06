import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/checkbox_rarity.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

dialogFilterWeapon() async {
  WeaponController weaponController = Get.find<WeaponController>();
  await Get.bottomSheet(
    isScrollControlled: true,
    Container(
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: Container(
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
            const Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _FilterWeapon(),
                          _FilterSubstat(),
                          _Rarity(),
                          _SortName(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _Button(
              accept: () async {
                weaponController.filter();
              },
              reset: () async {
                await dialogConfirm("confirm".tr, "reset_filter_comfirm".tr,
                    () {
                  weaponController.reset();
                });
              },
            )
          ],
        ),
      ),
    ),
  );
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
    WeaponController weaponController = Get.find<WeaponController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Image.asset(Tools.getAssetWeaponType(weapon) ?? "",
              height: 30, width: 30),
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: weaponController.checkWeaponFilters[index],
                onChanged: (value) {
                  weaponController.checkWeaponFilter(index);
                });
          }, weaponController.checkWeaponFilters),
        ],
      ),
    );
  }
}

class _FilterSubstat extends StatelessWidget {
  const _FilterSubstat();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "substat".tr,
          style: ThemeApp.textStyle(isDark: Get.isDarkMode),
        ),
        Center(
          child: ListView.builder(
            primary: false,
            itemCount: weaponController.substatWeaponFilter.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _ItemSubstat(
                substat: weaponController.substatWeaponFilter[index],
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemSubstat extends StatelessWidget {
  final String substat;
  final int index;
  const _ItemSubstat({required this.substat, required this.index});

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: weaponController.substatWeaponFilters[index],
                onChanged: (value) {
                  weaponController.checkSubstatFilter(index);
                });
          }, weaponController.substatWeaponFilters),
          Text(
            substat,
            style: ThemeApp.textStyle(isDark: Get.isDarkMode),
          )
        ],
      ),
    );
  }
}

class _Rarity extends StatelessWidget {
  const _Rarity();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
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
                      weaponController.checkOneRarity();
                    });
              }, weaponController.oneRarity),
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
      ),
    );
  }
}

class _ItemRarity extends StatelessWidget {
  final int index;
  const _ItemRarity({required this.index});

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    return ObxValue<RxList<bool>>((p0) {
      return CheckboxRarity(
        value: weaponController.checkRarityFilters[index],
        onTap: () {
          weaponController.checkRarityFilter(index);
        },
      );
    }, weaponController.checkRarityFilters);
  }
}

class _SortName extends StatelessWidget {
  const _SortName();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
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
                    weaponController.checkSortFilter(value ?? 0);
                  }),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile(
                  title: const Text("Z -> A"),
                  value: 1,
                  groupValue: p0.value,
                  onChanged: (value) {
                    weaponController.checkSortFilter(value ?? 1);
                  }),
            ),
          ],
        );
      }, weaponController.sortName),
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
