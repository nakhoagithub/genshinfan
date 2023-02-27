import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_ascension.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_info.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_refinement.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_stats.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_story.dart';
import 'package:get/get.dart';

class WeaponScreen extends StatelessWidget {
  const WeaponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WeaponController weaponController = Get.find<WeaponController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: ThemeApp.colorCard(isDark: Get.isDarkMode),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "weapon_information".tr,
          ),
        ),
        body: weaponController.weapon.value == null
            ? Center(
                child: Text("choose_weapon".tr),
              )
            : Stack(
                children: [
                  SizedBox(
                    width: context.mediaQuerySize.width,
                    height: context.mediaQuerySize.height,
                    child: Opacity(
                      opacity: 0.3,
                      child: CachedNetworkImage(
                        imageUrl:
                            Config.urlImage("${weaponController.imageGacha}"),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: LinearProgressIndicator(
                              value: progress.progress,
                              color: ThemeApp.colorPrimary(),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: weaponController.scrollController,
                    child: const Column(
                      children: [
                        InformationWeapon(),
                        WeaponAscensionView(),
                        WeaponRefinement(),
                        WeaponStats(),
                        WeaponStory(),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
