import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/localization.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class DialogLanguage extends StatelessWidget {
  const DialogLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      height: Get.height * 0.8,
      width: double.infinity,
      color: Get.theme.colorScheme.background,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "select_language".tr,
            style: ThemeApp.textStyle(
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
                itemCount: Localization.locales.length,
                itemBuilder: (context, index) {
                  String language = Localization.listLanguageView[index];
                  String languageCode =
                      Localization.locales[index].languageCode;
                  String? countryCode = Localization.locales[index].countryCode;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // Get.dialog(await dialogConfirm(
                        //     "notification_change_language".tr, () {
                        //   Get.find<AppController>().updateLanguage(langCode);
                        // }));
                        dialogConfirm("notification".tr,
                            "notification_change_language".tr, () async {
                          await Get.find<MainController>()
                              .updateLanguage(languageCode, countryCode);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            language,
                            style: ThemeApp.textStyle(),
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
