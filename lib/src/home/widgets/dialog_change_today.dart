import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/home/controllers/home_controller.dart';
import 'package:get/get.dart';

dialogChangeToday() async {
  HomeController homeController = Get.find<HomeController>();
  Get.bottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    Container(
      width: Get.mediaQuery.size.width,
      color: Get.theme.colorScheme.background,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "change_today".tr,
              style: ThemeApp.textStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            return Wrap(
              spacing: 4,
              children: [
                ...homeController.todays.map((e) {
                  return RawChip(
                    label: Text(e),
                    selected: e == homeController.todaySelected.value,
                    onSelected: (value) {
                      homeController.todaySelected.value = e;
                      homeController.changeDate();
                    },
                  );
                }),
              ],
            );
          }),
          Material(
            color: Colors.transparent,
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(50),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: const Text("OK"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
