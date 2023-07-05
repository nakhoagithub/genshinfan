import 'package:flutter/material.dart';
import 'package:genshinfan/views/craft/views/craft_screen.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/achievement/views/achievement_page.dart';
import 'package:genshinfan/views/achievement/views/achievement_screen.dart';
import 'package:genshinfan/views/animal/views/animal_page.dart';
import 'package:genshinfan/views/animal/views/animal_screen.dart';
import 'package:genshinfan/views/artifact/views/artifact_page.dart';
import 'package:genshinfan/views/artifact/views/artifact_screen.dart';
import 'package:genshinfan/views/craft/views/craft_page.dart';
import 'package:genshinfan/views/domain/views/domain_page.dart';
import 'package:genshinfan/views/domain/views/domain_screen.dart';
import 'package:genshinfan/views/enemy/views/enemy_page.dart';
import 'package:genshinfan/views/enemy/views/enemy_screen.dart';
import 'package:genshinfan/views/geography/views/geography_page.dart';
import 'package:genshinfan/views/geography/views/geography_screen.dart';
import 'package:genshinfan/views/home/views/home_page.dart';
import 'package:genshinfan/views/namecard/views/namecard_page.dart';
import 'package:genshinfan/views/namecard/views/namecard_screen.dart';
import 'package:genshinfan/views/outfit/views/outfit_page.dart';
import 'package:genshinfan/views/outfit/views/outfit_screen.dart';
import 'package:genshinfan/views/resource/views/resource_page.dart';
import 'package:genshinfan/views/resource/views/resource_screen.dart';
import 'package:genshinfan/views/weapon/views/weapon_page.dart';
import 'package:genshinfan/views/weapon/views/weapon_screen.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/icon_app.dart';
import 'package:genshinfan/views/widgets/slide_layout.dart';
import 'package:genshinfan/views/windglider/views/windglider_page.dart';
import 'package:genshinfan/views/windglider/views/windglider_screen.dart';
import 'package:get/get.dart';
import 'character/views/character_page.dart';
import 'character/views/character_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    HomeController homeController = Get.put(HomeController());

    List<ItemSlide> menus = [
      ItemSlide(
        iconMenu: Image.asset("assets/icon/play_store_512.png"),
        left: const HomePage(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_character.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const CharacterPage(),
        center: const CharacterScreen(),
        // right: SizedBox(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_weapon.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const WeaponPage(),
        center: const WeaponScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Activity_DoubleReward.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const ResourcePage(),
        center: const ResourceScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_artifact.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const ArtifactPage(),
        center: const ArtifactScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_dungeon.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const DomainPage(),
        center: const DomainScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_enemy.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const EnemyPage(),
        center: const EnemyScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_HomeWorldTabIcon_2_Animals.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const AnimalPage(),
        center: const AnimalScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_achievement.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const AchievementGroupPage(),
        center: const AchievementGroupScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_BtnIcon_NameCard.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const NamecardPage(),
        center: const NamecardScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Intee_Combine.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const CraftPage(),
        center: const CraftScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_BtnIcon_AvatarList.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const OutfitPage(),
        center: const OutfitScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Intee_Explore_0.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const GeographyPage(),
        center: const GeographyScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/UI_Icon_Activity_FleurFair_FallGame.png",
          color: Get.theme.colorScheme.onSurface,
        ),
        left: const WindgliderPage(),
        center: const WindgliderScreen(),
      ),
    ];

    List<Widget> actionBottomLeftBar = [
      IconApp(
        onTap: () {
          dialogConfirm(
            "genshin_map".tr,
            "notification_open_genshin_map".tr,
            () {
              Get.find<HomeController>().openGenshinMap();
            },
          );
        },
        child: Image.asset(
          "assets/images/UI_HomeWorldTabIcon_2_Teleport.png",
          color: Get.theme.colorScheme.onSurface,
        ),
      ),
      Obx(
        () => IconApp(
          onTap: () {
            Get.toNamed("/setting");
          },
          notification: Get.find<HomeController>().haveNewVesion.value,
          child: const Icon(Icons.settings),
        ),
      ),
    ];

    return Scaffold(
      body: SlideLayout(
        items: menus,
        streamChangeScreen: homeController.homeStream,
        iconBackgroundColor: Get.theme.colorScheme.onInverseSurface,
        iconColor: Get.theme.colorScheme.onSurface,
        indicatorColor: Get.theme.colorScheme.tertiary,
        actionBottomLeftBar: actionBottomLeftBar,
      ),
    );
  }
}
