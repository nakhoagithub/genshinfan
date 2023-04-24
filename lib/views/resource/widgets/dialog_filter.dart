import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_filter_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/checkbox_rarity.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

dialogFilterResource() async {
  ResourceFilterController resourceFilterController =
      Get.put(ResourceFilterController());
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
                "filter_resource".tr,
                style: ThemeApp.textStyle(
                  isDark: Get.isDarkMode,
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
              resourceFilterController.filter();
            },
            reset: () async {
              await dialogConfirm("confirm".tr, "reset_filter_comfirm".tr, () {
                resourceFilterController.reset();
              });
            },
          )
        ],
      ),
    ),
  );
}

class _FilterSubstat extends StatelessWidget {
  const _FilterSubstat();

  @override
  Widget build(BuildContext context) {
    ResourceFilterController resourceFilterController =
        Get.find<ResourceFilterController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "substat".tr,
          style: ThemeApp.textStyle(isDark: Get.isDarkMode),
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
                    value: resourceFilterController.substatAllFilter.value,
                    onChanged: (value) {
                      resourceFilterController.checkAllSubstat();
                    });
              }, resourceFilterController.substatAllFilter),
              Expanded(
                child: Text(
                  "all".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeApp.textStyle(isDark: Get.isDarkMode),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          primary: false,
          itemCount: resourceFilterController.substatResourceFilters.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _ItemSubstat(
              substat: resourceFilterController.substatResourceFilters[index],
              index: index,
            );
          },
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
    ResourceFilterController resourceFilterController =
        Get.find<ResourceFilterController>();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 30,
      child: Row(
        children: [
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: resourceFilterController
                    .selectSubstatResourceFilters[index],
                onChanged: (value) {
                  resourceFilterController.checkSubstatFilter(index);
                });
          }, resourceFilterController.selectSubstatResourceFilters),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                substat,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeApp.textStyle(isDark: Get.isDarkMode),
              ),
            ),
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
    ResourceFilterController resourceFilterController =
        Get.find<ResourceFilterController>();
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
                      resourceFilterController.checkOneRarity();
                    });
              }, resourceFilterController.oneRarity),
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
    ResourceFilterController resourceFilterController =
        Get.find<ResourceFilterController>();
    return ObxValue<RxList<bool>>((p0) {
      return CheckboxRarity(
        value: resourceFilterController.checkRarityFilters[index],
        onTap: () {
          resourceFilterController.checkRarityFilter(index);
        },
      );
    }, resourceFilterController.checkRarityFilters);
  }
}

class _SortName extends StatelessWidget {
  const _SortName();

  @override
  Widget build(BuildContext context) {
    ResourceFilterController resourceFilterController =
        Get.find<ResourceFilterController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ObxValue((p0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "sort_name".tr,
              style: ThemeApp.textStyle(isDark: Get.isDarkMode),
            ),
            SizedBox(
              height: 30,
              child: RadioListTile(
                  title: const Text("A -> Z"),
                  value: 0,
                  groupValue: p0.value,
                  onChanged: (value) {
                    resourceFilterController.checkSortFilter(value ?? 0);
                  }),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile(
                  title: const Text("Z -> A"),
                  value: 1,
                  groupValue: p0.value,
                  onChanged: (value) {
                    resourceFilterController.checkSortFilter(value ?? 1);
                  }),
            ),
          ],
        );
      }, resourceFilterController.sortName),
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
              // color: ThemeApp.colorText(isDark: Get.isDarkMode),
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
              // color: ThemeApp.colorText(isDark: Get.isDarkMode),
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
