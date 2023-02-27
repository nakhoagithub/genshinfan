import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/controllers/setting_controller.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/setting/widgets/change_language.dart';
import 'package:genshinfan/views/setting/widgets/change_theme.dart';
import 'package:genshinfan/views/setting/widgets/dialog_language.dart';
import 'package:genshinfan/views/setting/widgets/info_user.dart';
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
            TitleSetting(title: "user_information".tr),
            const InfoUser(),
            // setting
            TitleSetting(title: "setting".tr),
            ItemSetting(
              icon: const Icon(Icons.dark_mode_outlined),
              title: "dark_theme".tr,
              child: const SwitchThemeApp(),
            ),

            // change language
            ItemSetting(
              icon: const Icon(Icons.language_rounded),
              title: "change_language".tr,
              child: const ChangeLanguage(),
              onTap: () {
                Get.bottomSheet(const DialogLanguage());
              },
            ),

            // update
            Obx(
              () {
                bool haveNewVersion =
                    Get.find<HomeController>().haveNewVesion.value;
                return ItemSetting(
                  icon: const Icon(Icons.update_rounded, size: 20),
                  title: "update".tr,
                  description: "description_update_setting".tr,
                  notification: haveNewVersion,
                  onTap: () {
                    Get.find<SettingController>().updateData();
                  },
                );
              },
            ),

            // đóng góp build nhân vật
            TitleSetting(title: "contribute".tr),
            ItemSetting(
              icon: const Icon(Icons.person_outline_rounded),
              title: "contribute_character_building".tr,
              onTap: () {
                Get.toNamed('/contribute_character_building');
              },
            ),
            // đóng góp bản dịch
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

            // gửi mail
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
            // tham gia Discord
            ItemSetting(
              icon: Image.asset(
                "assets/images/ic_discord.png",
                height: 24,
                width: 24,
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
