import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/resources/utils/localization.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class DialogLanguage extends StatelessWidget {
  const DialogLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      height: 300,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: ThemeApp.colorScaffold(isDark: Get.isDarkMode),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "choose_language".tr,
            style: ThemeApp.textStyle(
              isDark: Get.isDarkMode,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: Localization.langCodes.length,
                itemBuilder: (context, index) {
                  String language =
                      Localization.mapLanguage[Localization.langCodes[index]];
                  String langCode = Localization.langCodes[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // Get.dialog(await dialogConfirm(
                        //     "notification_change_language".tr, () {
                        //   Get.find<AppController>().updateLanguage(langCode);
                        // }));
                        dialogConfirm("notification".tr,
                            "notification_change_language".tr, () {
                          Get.find<AppController>().updateLanguage(langCode);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            language,
                            style: ThemeApp.textStyle(isDark: Get.isDarkMode),
                          ),
                        ),
                      ),
                    ),
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
