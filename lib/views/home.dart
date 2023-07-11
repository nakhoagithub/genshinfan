import 'package:flutter/material.dart';
import 'package:genshinfan/views/achievement/views/achievement_page.dart';
import 'package:genshinfan/views/animal/views/animal_page.dart';
import 'package:genshinfan/views/artifact/views/artifact_page.dart';
import 'package:genshinfan/views/craft/views/craft_page.dart';
import 'package:genshinfan/views/domain/views/domain_page.dart';
import 'package:genshinfan/views/enemy/views/enemy_page.dart';
import 'package:genshinfan/views/food/views/food_page.dart';
import 'package:genshinfan/views/geography/views/geography_page.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/home/views/home_page.dart';
import 'package:genshinfan/views/namecard/views/namecard_page.dart';
import 'package:genshinfan/views/outfit/views/outfit_page.dart';
import 'package:genshinfan/views/resource/views/resource_page.dart';
import 'package:genshinfan/views/weapon/views/weapon_page.dart';
import 'package:genshinfan/app_layout.dart';
import 'package:genshinfan/views/windglider/views/windglider_page.dart';
import 'package:get/get.dart';
import 'character/views/character_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    Get.put(HomeController());

    // List<Widget> actionBottomLeftBar = [
    //   IconApp(
    //     onTap: () {
    //       dialogConfirm(
    //         "genshin_map".tr,
    //         "notification_open_genshin_map".tr,
    //         () {
    //           Get.find<HomeController>().openGenshinMap();
    //         },
    //       );
    //     },
    //     child: Image.asset(
    //       "assets/images/UI_HomeWorldTabIcon_2_Teleport.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //   ),
    //   Obx(
    //     () => IconApp(
    //       onTap: () {
    //         Get.toNamed("/setting");
    //       },
    //       notification: Get.find<HomeController>().haveNewVesion.value,
    //       child: const Icon(Icons.settings),
    //     ),
    //   ),
    // ];

    List<ItemLayout> items = [
      ItemLayout(
        iconMenu: Image.asset("assets/icons/play_store_512.png"),
        content: const HomePage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_HomeWorldTabIcon_2_Character.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const CharacterPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_TheatreMechanicus_Icon_Mechanism.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const WeaponPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Activity_DoubleReward.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const ResourcePage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_BtnIcon_RelicType1.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const ArtifactPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_BtnIcon_DungeonFactor.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const DomainPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Activity_FoodDelivery.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const FoodPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_HomeWorldTabIcon_2_Monsterhouse.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const EnemyPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_HomeWorldTabIcon_2_Animals.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const AnimalPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_AchiementIcon.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const AchievementGroupPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_BtnIcon_NameCard.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const NamecardPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Intee_Combine.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const CraftPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_BtnIcon_AvatarList.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const OutfitPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Intee_Explore_0.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const GeographyPage(),
      ),
      ItemLayout(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Activity_FleurFair_FallGame.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        content: const WindgliderPage(),
      ),
    ];

    return Scaffold(
      body: AppLayout(
        items: items,
      ),
      // body: SlideLayout(
      //   items: menus,
      //   streamChangeScreen: homeController.homeStream,
      //   iconBackgroundColor: Get.theme.colorScheme.onInverseSurface,
      //   iconColor: Get.theme.colorScheme.onSurface,
      //   indicatorColor: Get.theme.colorScheme.tertiary,
      //   actionBottomLeftBar: actionBottomLeftBar,
      // ),
    );
  }
}
