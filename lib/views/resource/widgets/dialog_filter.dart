import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/checkbox_rarity.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

dialogFilterResource() async {
  ResourceController resourceController = Get.find<ResourceController>();
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
                resourceController.filter();
              },
              reset: () async {
                await dialogConfirm("confirm".tr, "reset_filter_comfirm".tr,
                    () {
                  resourceController.reset();
                });
              },
            )
          ],
        ),
      ),
    ),
  );
}

class _FilterSubstat extends StatelessWidget {
  const _FilterSubstat();

  @override
  Widget build(BuildContext context) {
    ResourceController resourceController = Get.find<ResourceController>();
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
                    value: resourceController.substatAllFilter.value,
                    onChanged: (value) {
                      resourceController.checkAllSubstat();
                    });
              }, resourceController.substatAllFilter),
              Text(
                "all".tr,
                style: ThemeApp.textStyle(isDark: Get.isDarkMode),
              ),
            ],
          ),
        ),
        Center(
          child: ListView.builder(
            primary: false,
            itemCount: resourceController.substatResourceFilter.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _ItemSubstat(
                substat: resourceController.substatResourceFilter[index],
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
    ResourceController resourceController = Get.find<ResourceController>();
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          ObxValue<RxList<bool>>((p0) {
            return Checkbox(
                activeColor: ThemeApp.theme.primaryColor,
                value: resourceController.substatResourceFilters[index],
                onChanged: (value) {
                  resourceController.checkSubstatFilter(index);
                });
          }, resourceController.substatResourceFilters),
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
    ResourceController resourceController = Get.find<ResourceController>();
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
                      resourceController.checkOneRarity();
                    });
              }, resourceController.oneRarity),
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
    ResourceController resourceController = Get.find<ResourceController>();
    return ObxValue<RxList<bool>>((p0) {
      return CheckboxRarity(
        value: resourceController.checkRarityFilters[index],
        onTap: () {
          resourceController.checkRarityFilter(index);
        },
      );
    }, resourceController.checkRarityFilters);
  }
}

class _SortName extends StatelessWidget {
  const _SortName();

  @override
  Widget build(BuildContext context) {
    ResourceController resourceController = Get.find<ResourceController>();
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
                    resourceController.checkSortFilter(value ?? 0);
                  }),
            ),
            SizedBox(
              height: 40,
              child: RadioListTile(
                  title: const Text("Z -> A"),
                  value: 1,
                  groupValue: p0.value,
                  onChanged: (value) {
                    resourceController.checkSortFilter(value ?? 1);
                  }),
            ),
          ],
        );
      }, resourceController.sortName),
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
