import 'package:flutter/material.dart';
import 'package:genshinfan/views/artifact/artifact_page.dart';
import 'package:genshinfan/views/artifact/artifact_screen.dart';
import 'package:genshinfan/views/domain/domain_page.dart';
import 'package:genshinfan/views/domain/domain_screen.dart';
import 'package:genshinfan/views/enemy/enemy_page.dart';
import 'package:genshinfan/views/enemy/enemy_screen.dart';
import 'package:genshinfan/views/home/home_page.dart';
import 'package:genshinfan/views/resource/resource_page.dart';
import 'package:genshinfan/views/resource/resource_screen.dart';
import 'package:genshinfan/views/weapon/weapon_page.dart';
import 'package:genshinfan/views/weapon/weapon_screen.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/icon_app.dart';
import 'package:genshinfan/views/widgets/slide_layout.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../resources/utils/theme.dart';
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
          color: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        ),
        left: const CharacterPage(),
        center: const CharacterScreen(),
        // right: SizedBox(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_weapon.png",
          color: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        ),
        left: const WeaponPage(),
        center: const WeaponScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_material.png",
          color: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        ),
        left: const ResourcePage(),
        center: const ResourceScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_artifact.png",
          color: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        ),
        left: const ArtifactPage(),
        center: const ArtifactScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_dungeon.png",
          color: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        ),
        left: const DomainPage(),
        center: const DomainScreen(),
      ),
      ItemSlide(
        iconMenu: Image.asset(
          "assets/images/ic_enemy.png",
          color: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        ),
        left: const EnemyPage(),
        center: const EnemyScreen(),
      ),
    ];

    List<Widget> actionBottomLeftBar = [
      InkWell(
        onTap: () async {
          dialogConfirm(
            "genshin_map".tr,
            "notification_open_genshin_map".tr,
            () {
              Get.find<HomeController>().openGenshinMap();
            },
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "assets/images/ic_map1.png",
          height: 40,
          width: 40,
          color: ThemeApp.colorText(isDark: Get.isDarkMode),
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
        iconBackgroundColor:
            ThemeApp.colorBackgroundIcon(isDark: Get.isDarkMode),
        iconColor: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        indicatorColor: ThemeApp.colorText(isDark: Get.isDarkMode),
        actionBottomLeftBar: actionBottomLeftBar,
      ),
    );
  }
}
