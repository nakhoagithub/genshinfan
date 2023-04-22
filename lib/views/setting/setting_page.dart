import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/controllers/setting_controller.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/setting/widgets/about_app.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/setting/widgets/change_language.dart';
import 'package:genshinfan/views/setting/widgets/change_theme.dart';
import 'package:genshinfan/views/setting/widgets/dialog_language.dart';
import 'package:genshinfan/views/setting/widgets/info_user.dart';
import 'package:genshinfan/views/widgets/item_menu.dart';
import 'package:genshinfan/views/setting/widgets/item_traffic.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/title_of_menu.dart';
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
            TitleApp(title: "user_information".tr),
            const InfoUser(),
            Obx(
              () {
                int role = Get.find<AppController>().userApp.value?.role ?? 10;
                // nếu thuộc Config.roleAdmins thì có quyền vào menu admin
                return !Tools.getRoleMenuAdmin(role)
                    ? const SizedBox()
                    : ItemMenu(
                        icon: const Icon(Icons.admin_panel_settings_rounded,
                            size: 20),
                        title: "admin".tr,
                        description: "admin_description".tr,
                        onTap: () {
                          Get.toNamed('/admin');
                        },
                      );
              },
            ),
            // setting
            TitleApp(title: "setting".tr),
            ItemMenu(
              icon: const Icon(Icons.dark_mode_outlined),
              title: "dark_theme".tr,
              child: const SwitchThemeApp(),
            ),

            // change language
            ItemMenu(
              icon: const Icon(Icons.language_rounded),
              title: "change_language".tr,
              child: const ChangeLanguage(),
              onTap: () {
                Get.bottomSheet(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  const DialogLanguage(),
                );
              },
            ),

            // update
            Obx(
              () {
                bool haveNewVersion =
                    Get.find<HomeController>().haveNewVesion.value;
                return ItemMenu(
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
            TitleApp(title: "contribute".tr),
            ItemMenu(
              icon: const Icon(Icons.person_outline_rounded),
              title: "character_building".tr,
              onTap: () {
                if (Get.find<AppController>().userApp.value != null ||
                    Get.find<AppController>().user.value != null) {
                  Get.toNamed('/contribute_character_building');
                } else {
                  dialogInfo("required_login".tr);
                }
              },
            ),
            // đóng góp bản dịch
            ItemMenu(
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
            TitleApp(title: "other".tr),

            // gửi mail
            ItemMenu(
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
            ItemMenu(
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
            const AboutApp(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
