import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/views/achievement/achievement_page.dart';
import 'package:genshinfan/views/achievement/achievement_screen.dart';
import 'package:genshinfan/views/animal/animal_page.dart';
import 'package:genshinfan/views/animal/animal_screen.dart';
import 'package:genshinfan/views/artifact/artifact_page.dart';
import 'package:genshinfan/views/artifact/artifact_screen.dart';
import 'package:genshinfan/views/craft/craft_page.dart';
import 'package:genshinfan/views/craft/craft_screen.dart';
import 'package:genshinfan/views/domain/domain_page.dart';
import 'package:genshinfan/views/domain/domain_screen.dart';
import 'package:genshinfan/views/enemy/enemy_page.dart';
import 'package:genshinfan/views/enemy/enemy_screen.dart';
import 'package:genshinfan/views/home/home_page.dart';
import 'package:genshinfan/views/namecard/namecard_page.dart';
import 'package:genshinfan/views/namecard/namecard_screen.dart';
import 'package:genshinfan/views/resource/resource_page.dart';
import 'package:genshinfan/views/resource/resource_screen.dart';
import 'package:genshinfan/views/weapon/weapon_page.dart';
import 'package:genshinfan/views/weapon/weapon_screen.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/icon_app.dart';
import 'package:genshinfan/views/widgets/slide_layout.dart';
import 'package:get/get.dart';
import 'character/character_page.dart';
import 'character/character_screen.dart';

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
        icon: Image.asset(
          "assets/images/ic_map1.png",
          height: 40,
          width: 40,
          color: Get.theme.colorScheme.onSurface,
        ),
      ),
      Obx(
        () => IconApp(
          onTap: () {
            Get.toNamed("/setting");
          },
          notification: Get.find<HomeController>().haveNewVesion.value,
          icon: const Icon(Icons.settings),
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
