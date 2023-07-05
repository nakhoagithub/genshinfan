import 'package:flutter/material.dart';
import 'package:genshinfan/views/weapon/controllers/weapon_filter_controller.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/checkbox_rarity.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

dialogFilterWeapon() async {
  WeaponFilterController weaponFilterController =
      Get.put(WeaponFilterController());
  await Get.bottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isScrollControlled: true,
    Container(
      color: Get.theme.cardColor,
      height: Get.height * 0.9,
      width: Get.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                "filter_weapon".tr,
                style: ThemeApp.textStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                        _Rarity(),
                        _FilterSubstat(),
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
              weaponFilterController.filter();
            },
            reset: () async {
              await dialogConfirm("confirm".tr, "reset_filter_comfirm".tr, () {
                weaponFilterController.reset();
              });
            },
          )
        ],
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
          style: ThemeApp.textStyle(),
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
    WeaponFilterController weaponFilterController =
        Get.find<WeaponFilterController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 30,
      child: Column(
        children: [
          Image.asset(
            Tool.getAssetWeaponType(weapon) ?? "",
            height: 30,
            width: 30,
            color: Get.theme.colorScheme.onSurface,
          ),
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: weaponFilterController.checkWeaponFilters[index],
                onChanged: (value) {
                  weaponFilterController.checkWeaponFilter(index);
                });
          }, weaponFilterController.checkWeaponFilters),
        ],
      ),
    );
  }
}

class _FilterSubstat extends StatelessWidget {
  const _FilterSubstat();

  @override
  Widget build(BuildContext context) {
    WeaponFilterController weaponFilterController =
        Get.find<WeaponFilterController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "substat".tr,
          style: ThemeApp.textStyle(),
        ),

        // chọn tất cả
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: Row(
            children: [
              ObxValue<RxBool>((p0) {
                return Checkbox(
                    activeColor: ThemeApp.theme.primaryColor,
                    value: weaponFilterController.substatAllFilter.value,
                    onChanged: (value) {
                      weaponFilterController.checkAllSubstat();
                    });
              }, weaponFilterController.substatAllFilter),
              Text(
                "all".tr,
                style: ThemeApp.textStyle(),
              ),
            ],
          ),
        ),
        Center(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            itemCount: weaponFilterController.substatWeaponFilter.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _ItemSubstat(
                substat: weaponFilterController.substatWeaponFilter[index],
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
    WeaponFilterController weaponFilterController =
        Get.find<WeaponFilterController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 30,
      child: Row(
        children: [
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: weaponFilterController.substatWeaponFilters[index],
                onChanged: (value) {
                  weaponFilterController.checkSubstatFilter(index);
                });
          }, weaponFilterController.substatWeaponFilters),
          Text(
            substat,
            style: ThemeApp.textStyle(),
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
    WeaponFilterController weaponFilterController =
        Get.find<WeaponFilterController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "rarity".tr,
            style: ThemeApp.textStyle(),
          ),
          Row(
            children: [
              ObxValue((p0) {
                return Checkbox(
                    activeColor: ThemeApp.theme.primaryColor,
                    value: p0.value,
                    onChanged: (value) {
                      weaponFilterController.checkOneRarity();
                    });
              }, weaponFilterController.oneRarity),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "filter_with_rarity".tr,
                    style: ThemeApp.textStyle(),
                  ),
                ),
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
    WeaponFilterController weaponFilterController =
        Get.find<WeaponFilterController>();
    return ObxValue<RxList<bool>>((p0) {
      return CheckboxRarity(
        value: weaponFilterController.checkRarityFilters[index],
        onTap: () {
          weaponFilterController.checkRarityFilter(index);
        },
      );
    }, weaponFilterController.checkRarityFilters);
  }
}

class _SortName extends StatelessWidget {
  const _SortName();

  @override
  Widget build(BuildContext context) {
    WeaponFilterController weaponFilterController =
        Get.find<WeaponFilterController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ObxValue((p0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "sort_name".tr,
              style: ThemeApp.textStyle(),
            ),
            SizedBox(
              height: 30,
              child: RadioListTile(
                  title: const Text("A -> Z"),
                  value: 0,
                  groupValue: p0.value,
                  onChanged: (value) {
                    weaponFilterController.checkSortFilter(value ?? 0);
                  }),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile(
                  title: const Text("Z -> A"),
                  value: 1,
                  groupValue: p0.value,
                  onChanged: (value) {
                    weaponFilterController.checkSortFilter(value ?? 1);
                  }),
            ),
          ],
        );
      }, weaponFilterController.sortName),
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
              // color: ThemeApp.colorText(),
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
              // color: ThemeApp.colorText(),
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
