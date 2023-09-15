import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/windglider.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/windglider/controllers/windglider_controller.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class WindgliderPage extends StatelessWidget {
  const WindgliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    WindgliderController windgliderController =
        Get.find<WindgliderController>();
    return Obx(() {
      List<Windglider> windgliders = windgliderController.windgliders;
      return windgliders.isEmpty
          ? ListEmpty(title: "empty_windglider".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                windgliders.length,
                (index) => ItemGame(
                  title: windgliders[index].name,
                  rarity: windgliders[index].rarity,
                  linkImage:
                      Config.urlImage(windgliders[index].images?.nameicon),
                  onTap: () {
                    windgliderController.selectWindglider(windgliders[index]);
                    Get.toNamed("/windglider_info");
                  },
                ),
              ),
            );
    });
  }
}
