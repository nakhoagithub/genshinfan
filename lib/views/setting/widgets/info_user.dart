import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/icon_app.dart';
import 'package:get/get.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AppController appController = Get.find<AppController>();
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
    AppController appController = Get.find<AppController>();
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
                return const Center(
                  child: SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                );
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
                style: ThemeApp.textStyle(isDark: Get.isDarkMode, fontSize: 18),
              ),
              Text(
                "${user.email}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeApp.textStyle(isDark: Get.isDarkMode),
              ),
            ],
          ),
          const Spacer(),
          IconApp(
            onTap: () async {
              await Get.find<AppController>().logout();
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
            child: Image.asset(
              "assets/images/ic_user.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "login".tr,
            style: ThemeApp.textStyle(isDark: Get.isDarkMode, fontSize: 18),
          ),
          const Spacer(),
          IconApp(
            onTap: () async {
              await Get.find<AppController>().login();
            },
            icon: const Icon(Icons.login_outlined),
          ),
        ],
      ),
    );
  }
}
