import 'package:flutter/material.dart';
import 'package:genshinfan/src/craft/controllers/craft_controller.dart';
import 'package:genshinfan/models/game/craft.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class CraftPage extends StatelessWidget {
  const CraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("craft".tr),
      ),
      body: const _List(),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    CraftController craftController = Get.find<CraftController>();
    return Obx(() {
      List<Craft> crafts = craftController.crafts;
      return crafts.isEmpty
          ? ListEmpty(title: "empty_craft".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                crafts.length,
                (index) => ItemGame(
                  title: crafts[index].name,
                  rarity: crafts[index].resource?.rarity ?? "1",
                  linkImage:
                      Config.urlImage(crafts[index].resource?.images?.nameicon),
                  star: true,
                  onTap: () {
                    craftController.selectCraft(crafts[index]);
                    Get.toNamed("/craft_info");
                  },
                ),
              ),
            );
    });
  }
}
