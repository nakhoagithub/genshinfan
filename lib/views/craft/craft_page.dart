import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/controllers/craft_controller.dart';
import 'package:genshinfan/objects/craft.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class CraftPage extends StatelessWidget {
  const CraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "craft".tr,
            width: double.infinity,
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       // dialogFilterCraft();
            //     },
            //     icon: const Icon(Icons.filter_alt_rounded),
            //   )
            // ],
          ),
          const Expanded(child: _List()),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    CraftController craftController = Get.find<CraftController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Craft> crafts = craftController.crafts;
      return SizedBox(
        width: Config.widthCenter,
        child: crafts.isEmpty
            ? ListEmpty(title: "empty_craft".tr)
            : GridView.count(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: 3,
                childAspectRatio: sizeItem / (sizeItem * 1.215),
                children: List.generate(
                  crafts.length,
                  (index) => FadeInUp(
                    child: Center(
                      child: SizedBox(
                        width: sizeItem,
                        height: sizeItem * 1.215,
                        child: ItemGame(
                          title: crafts[index].name,
                          rarity: crafts[index].resource?.rarity ?? "1",
                          linkImage: Config.urlImage(
                              crafts[index].resource?.images?.nameicon),
                          star: true,
                          onTap: () {
                            craftController.selectCraft(crafts[index]);
                            homeController.pageCenter();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
