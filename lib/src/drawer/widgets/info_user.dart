import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/widgets/circular_progress.dart';
import 'package:genshinfan/src/widgets/dialog.dart';
import 'package:genshinfan/src/widgets/icon_app.dart';
import 'package:get/get.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    MainController appController = Get.find<MainController>();
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Obx(() {
          User? user = appController.user.value;
          return user == null ? const _NoLogin() : const _Logged();
        }),
      ),
    );
  }
}

class _Logged extends StatelessWidget {
  const _Logged();

  @override
  Widget build(BuildContext context) {
    context.theme;
    MainController appController = Get.find<MainController>();
    User user = appController.user.value!;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: user.photoURL ?? "",
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return const CircularProgressApp();
              },
              errorWidget: (context, url, error) {
                return Image.asset("assets/images/ic_user.png");
              },
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.displayName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeApp.textStyle(fontSize: 18),
              ),
              Text(
                "${user.email}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeApp.textStyle(),
              ),
            ],
          ),
          const Spacer(),
          IconApp(
            onTap: () async {
              await Get.find<MainController>().logout();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}

class _NoLogin extends StatelessWidget {
  const _NoLogin();

  @override
  Widget build(BuildContext context) {
    context.theme;
    return InkWell(
      onTap: () async {
        dialogProgress("loading".tr);
        await Get.find<MainController>().login();
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/ic_user.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "login".tr,
              style: ThemeApp.textStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
