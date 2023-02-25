import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/setting_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/widgets/backbutton.dart';
import 'package:genshinfan/views/setting/widgets/change_language.dart';
import 'package:genshinfan/views/setting/widgets/change_theme.dart';
import 'package:genshinfan/views/setting/widgets/dialog_language.dart';
import 'package:genshinfan/views/setting/widgets/item_setting.dart';
import 'package:genshinfan/views/setting/widgets/item_traffic.dart';
import 'package:genshinfan/views/setting/widgets/title_setting.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingController());
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("setting".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // setting
            TitleSetting(title: "setting".tr),
            ItemSetting(
              icon: const Icon(Icons.dark_mode_outlined),
              title: "dark_theme".tr,
              child: const SwitchThemeApp(),
            ),
            ItemSetting(
              icon: const Icon(Icons.language_rounded),
              title: "change_language".tr,
              child: const ChangeLanguage(),
              onTap: () {
                Get.bottomSheet(const DialogLanguage());
              },
            ),
            ItemSetting(
              icon: const Icon(Icons.update_rounded, size: 20),
              title: "update".tr,
              description: "description_update_setting".tr,
              onTap: () {
                dialogConfirm("notification".tr, "check_update".tr, () async {
                  dialogProgress("checking".tr);
                  await Future.delayed(const Duration(milliseconds: 500));
                  await Get.find<SettingController>().checkUpdateData();
                  Get.back();
                });
              },
            ),

            // contribute
            TitleSetting(title: "contribute".tr),
            ItemSetting(
              icon: const Icon(Icons.person_outline_rounded),
              title: "contribute_character_building".tr,
              onTap: () {},
            ),
            ItemSetting(
              icon: const Icon(Icons.g_translate_rounded),
              title: "contribute_translation".tr,
              onTap: () async {
                dialogConfirm("notification".tr, "contribute_translation".tr,
                    () {
                  Get.find<SettingController>().contributeTranslate();
                });
              },
            ),

            // other
            TitleSetting(title: "other".tr),
            ItemSetting(
              icon: const Icon(Icons.mail_outline_rounded),
              title: "send_feedback".tr,
              onTap: () async {
                dialogConfirm("notification".tr, "description_send_feedback".tr,
                    () {
                  Get.find<SettingController>().sendMail();
                });
              },
            ),
            ItemSetting(
              icon: Image.asset(
                "assets/images/ic_discord.png",
                height: 24,
                width: 24,
                color: ThemeApp.colorText(isDark: Get.isDarkMode),
              ),
              title: "join_discord".tr,
              onTap: () async {
                dialogConfirm("notification".tr, "join_discord".tr, () {
                  Get.find<SettingController>().joinDiscord();
                });
              },
            ),
            const TrafficApplication(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
