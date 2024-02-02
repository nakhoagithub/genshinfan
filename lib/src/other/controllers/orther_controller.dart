import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/src/home/controllers/home_controller.dart';
import 'package:genshinfan/src/layout.dart';
import 'package:genshinfan/src/widgets/dialog.dart';
import 'package:get/get.dart';

class OtherController extends GetxController {
  List<ItemMenuLayout> menus = [
    ItemMenuLayout(
      icon: "assets/images/UI_BtnIcon_RelicType1.png",
      title: "artifact".tr,
      keyPage: "artifact_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_BtnIcon_DungeonFactor.png",
      title: "domain".tr,
      keyPage: "domain_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_Icon_Activity_FoodDelivery.png",
      title: "food".tr,
      keyPage: "food_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_HomeWorldTabIcon_2_Monsterhouse.png",
      title: "enemy".tr,
      keyPage: "enemy_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_HomeWorldTabIcon_2_Animals.png",
      title: "animal".tr,
      keyPage: "animal_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_AchiementIcon.png",
      title: "achievement".tr,
      keyPage: "achievement_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_BtnIcon_NameCard.png",
      title: "namecard".tr,
      keyPage: "namecard_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_Icon_Intee_Combine.png",
      title: "craft".tr,
      keyPage: "craft_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_BtnIcon_AvatarList.png",
      title: "outfit".tr,
      keyPage: "outfit_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_Icon_Intee_Explore_0.png",
      title: "geography".tr,
      keyPage: "geography_page",
    ),
    ItemMenuLayout(
      icon: "assets/images/UI_Icon_Activity_FleurFair_FallGame.png",
      title: "windglider".tr,
      keyPage: "windglider_page",
    ),
  ];

  List<ItemMenuLayout> menusTool = [
    // ItemMenuLayout(
    //   icon: "assets/images/UI_Icon_Search.png",
    //   sizeIcon: 50,
    //   title: "search".tr,
    //   keyPage: "",
    //   onTap: () {
    //     Get.toNamed("/search_page");
    //   },
    // ),
    ItemMenuLayout(
      icon: "assets/images/UI_HomeWorldTabIcon_2_Teleport.png",
      title: "genshin_map".tr,
      keyPage: "",
      onTap: () {
        dialogConfirm(
          "genshin_map".tr,
          "notification_open_genshin_map".tr,
          () {
            Get.find<HomeController>().openGenshinMap();
          },
        );
      },
    ),
    ItemMenuLayout(
        icon: "assets/images/UI_BtnIcon_Wiki.png",
        title: "character_building".tr,
        keyPage: "",
        onTap: () {
          if (Get.find<MainController>().userApp.value != null ||
              Get.find<MainController>().user.value != null) {
            Get.toNamed('/contribute_character_building');
          } else {
            dialogInfo("required_login".tr);
          }
        }),
  ];
}
