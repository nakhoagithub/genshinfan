import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/weapon/controllers/weapon_controller.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_ascension.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_info.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_refinement.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_stats.dart';
import 'package:genshinfan/views/weapon/widgets/weapon_story.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class WeaponInfoPage extends StatelessWidget {
  const WeaponInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WeaponController weaponController = Get.find<WeaponController>();
    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "weapon_information".tr,
          ),
        ),
        body: weaponController.weapon.value == null
            ? PageEmpty(title: "select_weapon".tr)
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
                              // color: ThemeApp.colorPrimary(),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationWeapon(),
                        WeaponAscensionView(),
                        WeaponRefinement(),
                        WeaponStats(),
                        WeaponStory(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
