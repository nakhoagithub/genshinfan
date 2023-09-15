import 'package:flutter/material.dart';
import 'package:genshinfan/views/character/views/character_page.dart';
import 'package:genshinfan/views/drawer.dart';
import 'package:genshinfan/views/home/views/home_page.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/resource/views/resource_page.dart';
import 'package:genshinfan/views/weapon/views/weapon_page.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    LayoutController layoutController = Get.put(LayoutController());
    // List<ItemLayout> items = [
    //   ItemLayout(
    //     iconMenu: Image.asset("assets/icons/play_store_512.png"),
    //     content: const HomePage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_HomeWorldTabIcon_2_Character.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const CharacterPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_TheatreMechanicus_Icon_Mechanism.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const WeaponPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_Icon_Activity_DoubleReward.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const ResourcePage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_BtnIcon_RelicType1.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const ArtifactPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_BtnIcon_DungeonFactor.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const DomainPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_Icon_Activity_FoodDelivery.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const FoodPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_HomeWorldTabIcon_2_Monsterhouse.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const EnemyPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_HomeWorldTabIcon_2_Animals.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const AnimalPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_AchiementIcon.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const AchievementGroupPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_BtnIcon_NameCard.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const NamecardPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_Icon_Intee_Combine.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const CraftPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_BtnIcon_AvatarList.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const OutfitPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_Icon_Intee_Explore_0.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const GeographyPage(),
    //   ),
    //   ItemLayout(
    //     iconMenu: Image.asset(
    //       "assets/images/UI_Icon_Activity_FleurFair_FallGame.png",
    //       color: Get.theme.colorScheme.onSurface,
    //     ),
    //     content: const WindgliderPage(),
    //   ),
    // ];

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
              icon: Image.asset(
                "assets/images/UI_HomeWorldTabIcon_2_Suit.png",
                color: currentIndex == 0 ? Get.theme.primaryColor : null,
                height: 40,
                width: 40,
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
      return PageView(
        onPageChanged: (value) {
          layoutController.menu.value = value;
        },
        controller: layoutController.pageController,
        children: [
          const HomePage(),
          const CharacterPage(),
          const WeaponPage(),
          const ResourcePage(),
          Container(
            color: Colors.orange,
          ),
        ],
      );
    });
  }
}
