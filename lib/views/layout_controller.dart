import 'package:flutter/material.dart';
import 'package:genshinfan/views/character/widgets/dialog_filter.dart';
import 'package:genshinfan/views/resource/widgets/dialog_filter.dart';
import 'package:genshinfan/views/weapon/widgets/dialog_filter.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  RxBool loading = false.obs;
  RxInt menu = 0.obs;
  PageController? pageController;
  List<int> pageHasFilter = [1, 2, 3];
  RxString title = "Genshin Fan".obs;

  // item
  RxDouble width = 1.0.obs;
  RxDouble widthItem = 1.0.obs;
  RxInt crossAxisCount = 1.obs;
  RxDouble childAspectRatio = 1.0.obs;
  RxDouble widthItem3 = 1.0.obs;
  RxInt crossAxisCount3 = 1.obs;
  RxDouble childAspectRatio3 = 1.0.obs;

  void selectMenu(int value) {
    menu.value = value;
    pageController?.jumpToPage(
      value,
      // duration: const Duration(milliseconds: 200),
      // curve: Curves.ease,
    );
  }

  void onClickOpenFilter() {
    if (menu.value == 1) {
      dialogFilterCharacter();
    }
    if (menu.value == 2) {
      dialogFilterWeapon();
    }
    if (menu.value == 3) {
      dialogFilterResource();
    }
  }

  void onChangeTitle() {
    switch (menu.value) {
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
        title.value = "other".tr;
        break;
    }
  }

  void getWithItem() {
    double a = Get.width;
    double b = Get.height;
    if (a < b) {
      widthItem.value = a / 4 - 8;
      width.value = a;
      widthItem3.value = a / 3 - 8;
    } else if (a > b) {
      widthItem.value = b / 4 - 8;
      width.value = b;
      widthItem3.value = b / 3 - 8;
    } else {
      // a == b
      widthItem.value = a / 4 - 8;
      width.value = a;
      widthItem3.value = a / 3 - 8;
    }

    crossAxisCount.value = Get.width ~/ (widthItem.value + 4);
    childAspectRatio.value = widthItem.value / (widthItem.value * 1.215);
    crossAxisCount3.value = Get.width ~/ (widthItem3.value + 4);
    childAspectRatio3.value = widthItem3.value / (widthItem3.value * 1.215);
  }

  @override
  void onInit() {
    loading.value = true;
    pageController = PageController(initialPage: menu.value, keepPage: true);
    getWithItem();
    loading.value = false;
    super.onInit();
    
    menu.listen((p0) {
      onChangeTitle();
    });
  }
}
