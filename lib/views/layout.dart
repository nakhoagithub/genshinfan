import 'package:flutter/material.dart';
import 'package:genshinfan/views/character/views/character_page.dart';
import 'package:genshinfan/views/drawer.dart';
import 'package:genshinfan/views/home/views/home_page.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/orther/views/orther_page.dart';
import 'package:genshinfan/views/resource/views/resource_page.dart';
import 'package:genshinfan/views/weapon/views/weapon_page.dart';
import 'package:get/get.dart';

class ItemMenuLayout {
  final Widget icon;
  final String title;
  final String keyPage;
  const ItemMenuLayout({
    required this.icon,
    required this.title,
    required this.keyPage,
  });
}

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    LayoutController layoutController = Get.put(LayoutController());
    GlobalKey<ScaffoldState> key = GlobalKey();

    return Scaffold(
      key: key,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            key.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu_rounded),
        ),
        title: const Text("GenshinFan"),
        actions: [
          Obx(() {
            List<int> page = layoutController.pageHasFilter;
            return layoutController.menu.value == 0
                ? const SizedBox()
                // ? IconButton(
                //     onPressed: () {
                //       showSearch(
                //           context: context, delegate: HomeSearchBar());
                //     },
                //     icon: const Icon(Icons.search_rounded),
                //   )
                : page.contains(layoutController.menu.value)
                    ? IconButton(
                        onPressed: () {
                          layoutController.onClickOpenFilter();
                        },
                        icon: const Icon(Icons.filter_alt_rounded),
                      )
                    : const SizedBox();
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
                color: currentIndex == 1 ? Get.theme.primaryColor : null,
                height: 40,
                width: 40,
              ),
              label: "character".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_TheatreMechanicus_Icon_Mechanism.png",
                color: currentIndex == 2 ? Get.theme.primaryColor : null,
                height: 40,
                width: 40,
              ),
              label: "weapon".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_Icon_Activity_DoubleReward.png",
                color: currentIndex == 3 ? Get.theme.primaryColor : null,
                height: 40,
                width: 40,
              ),
              label: "resource".tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/UI_Icon_BP_StoryTab.png",
                color: currentIndex == 4 ? Get.theme.primaryColor : null,
                height: 40,
                width: 40,
              ),
              label: "orther".tr,
            ),
          ],
        );
      }),
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

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    LayoutController layoutController = Get.find<LayoutController>();
    return OrientationBuilder(builder: (p0, p1) {
      layoutController.getWithItem();
      print("chạy cái này");
      return PageView(
        onPageChanged: (value) {
          layoutController.menu.value = value;
        },
        controller: layoutController.pageController,
        children: const [
          HomePage(),
          CharacterPage(),
          WeaponPage(),
          ResourcePage(),
          OrtherPage(),
        ],
      );
    });
  }
}
