import 'package:flutter/material.dart';
import 'package:genshinfan/views/layout.dart';
import 'package:get/get.dart';

class OrtherController extends GetxController {
  List<ItemMenuLayout> menus = [
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_BtnIcon_RelicType1.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "artifact".tr,
      keyPage: "artifact_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_BtnIcon_DungeonFactor.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "domain".tr,
      keyPage: "domain_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_Icon_Activity_FoodDelivery.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "food".tr,
      keyPage: "food_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_HomeWorldTabIcon_2_Monsterhouse.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "enemy".tr,
      keyPage: "enemy_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_HomeWorldTabIcon_2_Animals.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "animal".tr,
      keyPage: "animal_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_AchiementIcon.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "achievement".tr,
      keyPage: "achievement_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_BtnIcon_NameCard.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "namecard".tr,
      keyPage: "namecard_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_Icon_Intee_Combine.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "craft".tr,
      keyPage: "craft_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_BtnIcon_AvatarList.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "outfit".tr,
      keyPage: "outfit_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_Icon_Intee_Explore_0.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "geography".tr,
      keyPage: "geography_page",
    ),
    ItemMenuLayout(
      icon: Image.asset(
        "assets/images/UI_Icon_Activity_FleurFair_FallGame.png",
        color: Get.theme.colorScheme.onSurface,
      ),
      title: "windglider".tr,
      keyPage: "windglider_page",
    ),
  ];
}
