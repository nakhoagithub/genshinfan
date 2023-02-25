import 'dart:developer';
import 'dart:io';

import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  void sendMail() async {
    final bool gmailinstalled =
        await FlutterMailer.isAppInstalled(Config.gmailSchema);

    if (gmailinstalled) {
      final MailOptions mailOptions = MailOptions(
        subject: 'GenshinFan App Feedback',
        recipients: [Config.mailDeveloper],
        isHTML: true,
        bccRecipients: [],
        ccRecipients: [],
        attachments: [],
        appSchema: Config.gmailSchema,
      );
      await FlutterMailer.send(mailOptions);
    }
  }

  void joinDiscord() async {
    if (await canLaunchUrl(Uri.parse(Config.linkJoinDiscord))) {
      await launchUrl(Uri.parse(Config.linkJoinDiscord),
          mode: LaunchMode.externalApplication);
    } else {
      // Fluttertoast.showToast(msg: "Error: Unable to open link!");
      log("Không thể mở liên kết ${Config.linkJoinDiscord}",
          name: "joinDiscord");
    }
  }

  void contributeTranslate() async {}

  void updateData() {
    dialogConfirm("notification".tr, "check_update".tr, () async {
      dialogProgress("checking".tr);
      await Future.delayed(const Duration(milliseconds: 500));
      List<Object?> result = await AppService().checkUpdateData();
      Get.back();
      if (result[0] as bool) {
        await dialogConfirm("notification".tr, "update_new_data".tr, () async {
          // đồng ý cập nhật dữ liệu
          if (await AppService().deleteFileData()) {
            Get.offAllNamed('/');
          } else {
            Fluttertoast.showToast(
                msg: "Error: Please delete application data!");
          }
        });
      } else {
        await dialogInfo("no_data_version".tr);
      }
    });
  }
}
