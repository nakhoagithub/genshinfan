import 'package:flutter/material.dart';
import 'package:genshinfan/views/drawer.dart';
import 'package:genshinfan/views/character/widgets/dialog_filter.dart';
import 'package:genshinfan/views/resource/widgets/dialog_filter.dart';
import 'package:genshinfan/views/weapon/widgets/dialog_filter.dart';
import 'package:genshinfan/views/widgets/home_search_bar.dart';
import 'package:get/get.dart';

class AppLayoutController extends GetxController {
  double menuSize = 60;
  List<int> pageHasFilter = [1, 2, 3];
  RxInt currentIndex = 0.obs;
  RxDouble widthCenter = (Get.width - 60).obs;
  RxString title = "Genshin Fan".obs;

  // item
  double widthItem = 80;
  double childAspectRatio() {
    return widthItem / (widthItem * 1.215);
  }

  int crossAxisCount() {
    return widthCenter.value ~/ (widthItem + 4);
  }

  // item big
  double widthItemBig = 110;
  double childAspectRatioBig() {
    return widthItemBig / (widthItemBig * 1.215);
  }

  int crossAxisCountBig() {
    return widthCenter.value ~/ (widthItemBig + 4);
  }

  void onTap(int index) {
    currentIndex.value = index;
  }

  void onClickOpenFilter() {
    if (currentIndex.value == 1) {
      dialogFilterCharacter();
    }
    if (currentIndex.value == 2) {
      dialogFilterWeapon();
    }
    if (currentIndex.value == 3) {
      dialogFilterResource();
    }
  }

  void onChangeTitle() {
    switch (currentIndex.value) {
      case 0:
        title.value = "Genshin Fan";
        break;
      case 1:
        title.value = "character".tr;
        break;
      case 2:
        title.value = "weapon".tr;
        break;
      case 3:
        title.value = "resource".tr;
        break;
      case 4:
        title.value = "artifact".tr;
        break;
      case 5:
        title.value = "domain".tr;
        break;
      case 6:
        title.value = "food".tr;
        break;
      case 7:
        title.value = "enemy".tr;
        break;
      case 8:
        title.value = "animal".tr;
        break;
      case 9:
        title.value = "achievement".tr;
        break;
      case 10:
        title.value = "namecard".tr;
        break;
      case 11:
        title.value = "craft".tr;
        break;
      case 12:
        title.value = "outfit".tr;
        break;
      case 13:
        title.value = "geography".tr;
        break;
      case 14:
        title.value = "windglider".tr;
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();

    currentIndex.listen((p0) {
      onChangeTitle();
    });
  }
}

class AppLayout extends StatelessWidget {
  final List<ItemLayout> items;
  const AppLayout({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    AppLayoutController appLayoutController = Get.put(AppLayoutController());
    GlobalKey<ScaffoldState> key = GlobalKey();
    return OrientationBuilder(
      builder: (context, orientation) {
        appLayoutController.widthCenter.value = Get.width - 60;
        return Scaffold(
          key: key,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            ),
            title: Obx(() {
              return Text(appLayoutController.title.value);
            }),
            actions: [
              Obx(() {
                List<int> page = appLayoutController.pageHasFilter;
                return appLayoutController.currentIndex.value == 0
                    ? IconButton(
                        onPressed: () {
                          showSearch(
                              context: context, delegate: HomeSearchBar());
                        },
                        icon: const Icon(Icons.search_rounded),
                      )
                    : page.contains(appLayoutController.currentIndex.value)
                        ? IconButton(
                            onPressed: () {
                              appLayoutController.onClickOpenFilter();
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
          body: Row(
            children: [
              _Menu(items: items),
              _Content(items: items),
            ],
          ),
          drawer: const DrawerApp(),
        );
      },
    );
  }
}

class _Menu extends StatelessWidget {
  final List<ItemLayout> items;
  const _Menu({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    print("build lại menu");
    AppLayoutController appLayoutController = Get.find<AppLayoutController>();
    return SizedBox(
      width: appLayoutController.menuSize,
      child: Column(
        children: [
          _IconMenu(
            index: 0,
            onTap: () => appLayoutController.onTap(0),
            child: items[0].iconMenu,
          ),
          const _Divider(),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length - 1,
            itemBuilder: (context, index) {
              int i = index + 1;
              return _IconMenu(
                index: i,
                onTap: () => appLayoutController.onTap(i),
                child: items[i].iconMenu,
              );
            },
          )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _IconMenu extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final Widget child;
  const _IconMenu({
    required this.index,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Duration duration = const Duration(milliseconds: 200);
    AppLayoutController appLayoutController = Get.find<AppLayoutController>();
    return Obx(() {
      int currentIndex = appLayoutController.currentIndex.value;
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              AnimatedContainer(
                duration: duration,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.tertiary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
                height: index == currentIndex
                    ? appLayoutController.menuSize * 0.5
                    : 0,
                width: 4,
              ),
              AnimatedContainer(
                duration: duration,
                margin: const EdgeInsets.only(left: 8),
                padding: index == 0 ? null : const EdgeInsets.all(5),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(index == currentIndex
                      ? appLayoutController.menuSize / 5
                      : appLayoutController.menuSize / 2),
                ),
                height: 42,
                width: 42,
                child: child,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Content extends StatelessWidget {
  final List<ItemLayout> items;
  const _Content({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    AppLayoutController appLayoutController = Get.find<AppLayoutController>();
    return Container(
      color: Get.theme.colorScheme.background,
      width: Get.width - appLayoutController.menuSize,
      child: Obx(() => Stack(
            children: [
              ...items.asMap().entries.map(
                (e) {
                  return Offstage(
                    offstage: appLayoutController.currentIndex.value == e.key
                        ? false
                        : true,
                    child: e.value.content,
                  );
                },
              ),
            ],
          )),
    );
  }
}

class ItemLayout {
  final Widget iconMenu;
  final Widget content;
  const ItemLayout({
    required this.iconMenu,
    required this.content,
  });
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5, top: 10),
      child: const Divider(
        color: Colors.grey,
        height: 1,
      ),
    );
  }
}
