import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:get/get.dart';

dialogConfirm(String title, String message, Function accept,
    {Function? cancel}) async {
  await Get.bottomSheet(
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
              title,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextCSS(
              message,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        if (cancel != null) {
                          await cancel();
                        }
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
          )
        ],
      ),
    ),
  );
}

dialogInfo(String message) async {
  await Get.bottomSheet(
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
              "information".tr,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextCSS(
              message,
              style: ThemeApp.textStyle(
                isDark: Get.isDarkMode,
              ),
            ),
          ),
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

dialogProgress(String message) async {
  await Get.dialog(
    AlertDialog(
      title: Text(message),
      content: LinearProgressIndicator(color: ThemeApp.theme.primaryColor),
    ),
    useSafeArea: true,
  );
}
