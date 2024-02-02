import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/src/character/views/character_page.dart';
import 'package:genshinfan/src/drawer.dart';
import 'package:genshinfan/src/home/views/home_page.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/other/views/other_page.dart';
import 'package:genshinfan/src/resource/views/resource_page.dart';
import 'package:genshinfan/src/weapon/views/weapon_page.dart';
import 'package:genshinfan/src/widgets/circular_progress.dart';
import 'package:genshinfan/src/widgets/icon_app.dart';
import 'package:get/get.dart';

class ItemMenuLayout {
  final String? icon;
  final double? sizeIcon;
  final Widget? widget;
  final String title;
  final String keyPage;
  final VoidCallback? onTap;
  const ItemMenuLayout({
    this.icon,
    this.sizeIcon,
    this.widget,
    required this.title,
    required this.keyPage,
    this.onTap,
  });
}

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    LayoutController layoutController = Get.find<LayoutController>();
    GlobalKey<ScaffoldState> key = GlobalKey();

    return Scaffold(
      key: key,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Obx(() {
          bool notification = Get.find<MainController>().haveNewVesion.value;
          return IconApp(
            onTap: () {
              key.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu_rounded),
            notification: notification,
          );
        }),
        // leading: IconButton(
        //   onPressed: () {
        //     key.currentState?.openDrawer();
        //   },
        //   icon: const Icon(Icons.menu_rounded),
        // ),
        title: const Text("GenshinFan"),
        actions: [
          Obx(() {
            int menu = layoutController.menu.value;
            return Wrap(
              children: [...layoutController.actions[menu]],
            );
          }),

          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.search),
          // ),
        ],
      ),
      body: const _Body(),
      drawer: const DrawerApp(),
      bottomNavigationBar: Obx(() {
        int currentIndex = layoutController.menu.value;
        return BottomNavigationBar(
          selectedItemColor: Get.theme.primaryColor,
          selectedIconTheme: IconThemeData(color: Get.theme.primaryColor),
          onTap: (value) {
            layoutController.selectMenu(value);
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  "assets/icons/play_store_512.png",
                  // color: currentIndex == 0 ? Get.theme.primaryColor : null,
                  height: 40,
                  width: 40,
                ),
              ),
              label: "home".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_HomeWorldTabIcon_2_Character.png",
                color: currentIndex == 1
                    ? Get.theme.primaryColor
                    : Get.theme.colorScheme.onSurface.withOpacity(0.7),
                height: 40,
                width: 40,
              ),
              label: "character".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_TheatreMechanicus_Icon_Mechanism.png",
                color: currentIndex == 2
                    ? Get.theme.primaryColor
                    : Get.theme.colorScheme.onSurface.withOpacity(0.7),
                height: 40,
                width: 40,
              ),
              label: "weapon".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_Icon_Activity_DoubleReward.png",
                color: currentIndex == 3
                    ? Get.theme.primaryColor
                    : Get.theme.colorScheme.onSurface.withOpacity(0.7),
                height: 40,
                width: 40,
              ),
              label: "resource".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_Icon_BP_StoryTab.png",
                color: currentIndex == 4
                    ? Get.theme.primaryColor
                    : Get.theme.colorScheme.onSurface.withOpacity(0.7),
                height: 40,
                width: 40,
              ),
              label: "other".tr,
            ),
          ],
        );
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    LayoutController layoutController = Get.find<LayoutController>();
    return Obx(() {
      bool loading = layoutController.loading.value;
      return loading
          ? const CircularProgressApp()
          : PageView(
              onPageChanged: (value) {
                layoutController.menu.value = value;
              },
              controller: layoutController.pageController,
              children: const [
                HomePage(),
                CharacterPage(),
                WeaponPage(),
                ResourcePage(),
                OtherPage(),
              ],
            );
    });
  }
}
