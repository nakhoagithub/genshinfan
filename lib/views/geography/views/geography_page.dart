import 'package:flutter/material.dart';
import 'package:genshinfan/views/geography/controllers/geography_controller.dart';
import 'package:genshinfan/models/game/geography.dart';
import 'package:genshinfan/views/geography/widgets/item_geography.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class GeographyPage extends StatelessWidget {
  const GeographyPage({super.key});

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
    GeographyController geographyController = Get.find<GeographyController>();
    return Obx(() {
      List<Geography> geographies = geographyController.geographies;
      return geographies.isEmpty
          ? ListEmpty(title: "empty_geography".tr)
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: geographies.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ItemGeography(
                  geography: geographies[index],
                  onTap: () {
                    geographyController.selectGeography(geographies[index]);
                    Get.toNamed("/geography_info");
                  },
                );
              },
            );
    });
  }
}
