import 'package:flutter/material.dart';
import 'package:genshinfan/app_layout.dart';
import 'package:genshinfan/views/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({super.key});

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
    ResourceController resourceController = Get.find<ResourceController>();
    return Obx(() {
      List<Resource> resources = resourceController.resourcesView;
      return resources.isEmpty
          ? ListEmpty(title: "empty_resource".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<AppLayoutController>().crossAxisCount(),
              childAspectRatio:
                  Get.find<AppLayoutController>().childAspectRatio(),
              children: List.generate(
                resources.length,
                (index) => ItemGame(
                  title: resources[index].name,
                  rarity: resources[index].rarity,
                  linkImage: Config.urlImage(resources[index].images?.nameicon),
                  star: true,
                  onTap: () {
                    resourceController.selectResource(resources[index]);
                    Get.toNamed("/resource_info");
                  },
                ),
              ),
            );
    });
  }
}
