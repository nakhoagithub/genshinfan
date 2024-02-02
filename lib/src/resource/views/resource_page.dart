import 'package:flutter/material.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({super.key});

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.theme;
    return Container(padding: const EdgeInsets.all(4), child: const _List());
  }

  @override
  bool get wantKeepAlive => true;
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
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
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
