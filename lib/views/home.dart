import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/config.dart';
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
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../resources/utils/theme.dart';
import '../resources/widgets/icon_app.dart';
import '../resources/widgets/slide_layout.dart';
import 'character/character_page.dart';
import 'character/character_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    HomeController homeController = Get.put(HomeController());

    List<ItemSlide> menus = [
      const ItemSlide(
        linkImageAsset: "assets/images/1024.png",
        left: HomePage(),
      ),
      const ItemSlide(
        linkImageAsset: "assets/images/ic_character.png",
        left: CharacterPage(),
        center: CharacterScreen(),
        // right: SizedBox(),
      ),
      const ItemSlide(
        linkImageAsset: "assets/images/ic_weapon.png",
        left: WeaponPage(),
        center: WeaponScreen(),
      ),
      const ItemSlide(
        linkImageAsset: "assets/images/ic_material.png",
        left: ResourcePage(),
        center: ResourceScreen(),
      ),
      const ItemSlide(
        linkImageAsset: "assets/images/ic_artifact.png",
        left: ArtifactPage(),
        center: ArtifactScreen(),
      ),
      const ItemSlide(
        linkImageAsset: "assets/images/ic_dungeon.png",
        left: DomainPage(),
        center: DomainScreen(),
      ),
      const ItemSlide(
        linkImageAsset: "assets/images/ic_enemy.png",
        left: EnemyPage(),
        center: EnemyScreen(),
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
          "assets/images/ic_map.png",
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
        // backgroundColor: ThemeApp.colorScaffold(isDark: Get.isDarkMode),
        iconBackgroundColor:
            ThemeApp.colorBackgroundIcon(isDark: Get.isDarkMode),
        iconColor: ThemeApp.colorIcon(isDark: Get.isDarkMode),
        indicatorColor: ThemeApp.colorText(isDark: Get.isDarkMode),
        actionBottomLeftBar: actionBottomLeftBar,
      ),
    );
  }
}
