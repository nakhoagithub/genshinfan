import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  RxString nameUser = "".obs;
  RxString imageUser = "".obs;

  void sendMail() async {
    final Email email = Email(
      subject: 'GenshinFan App Feedback',
      recipients: [Config.mailDeveloper],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

    // final bool gmailinstalled =
    //     await FlutterMailer.isAppInstalled(Config.gmailSchema);

    // if (gmailinstalled) {
    //   final MailOptions mailOptions = MailOptions(
    //     subject: 'GenshinFan App Feedback',
    //     recipients: [Config.mailDeveloper],
    //     isHTML: true,
    //     bccRecipients: [],
    //     ccRecipients: [],
    //     attachments: [],
    //     appSchema: Config.gmailSchema,
    //   );
    //   await FlutterMailer.send(mailOptions);
    // }
  }

  void joinDiscord() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String link = remoteConfig.getString(Config.keyLinkDiscord);

    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } else {
      // Fluttertoast.showToast(msg: "Error: Unable to open link!");
      log("Không thể mở liên kết ${Config.linkJoinDiscord}",
          name: "joinDiscord");
    }
  }

  void contributeTranslate() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String link = remoteConfig.getString(Config.keyLinkContributeTranslation);

    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } else {
      // Fluttertoast.showToast(msg: "Error: Unable to open link!");
      log("Không thể mở liên kết ${Config.linkJoinDiscord}",
          name: "joinDiscord");
    }
  }

  void updateData() {
    dialogConfirm("notification".tr, "check_update".tr, () async {
      dialogProgress("checking".tr);
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
