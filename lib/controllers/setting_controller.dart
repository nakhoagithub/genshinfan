import 'dart:developer';

import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:get/get.dart';
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
      log("Không thể mở liên kết ${Config.linkJoinDiscord}",
          name: "joinDiscord");
    }
  }

  void contributeTranslate() async {}

  Future<void> checkUpdateData() async {
    bool result = await AppService().checkUpdateData();
    print(result);
  }
}
