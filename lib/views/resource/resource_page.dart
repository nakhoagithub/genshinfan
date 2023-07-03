import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/resource/widgets/dialog_filter.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "resource".tr,
            width: double.infinity,
            actions: [
              IconButton(
                onPressed: () {
                  dialogFilterResource();
                },
                icon: const Icon(Icons.filter_alt_rounded),
              )
            ],
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
    ResourceController resourceController = Get.find<ResourceController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem3;
    return Obx(() {
      List<Resource> resources = resourceController.resources;
      return SizedBox(
        width: Config.widthCenter,
        child: resources.isEmpty
            ? ListEmpty(title: "empty_resource".tr)
            : GridView.count(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: 3,
                childAspectRatio: sizeItem / (sizeItem * 1.215),
                children: List.generate(
                  resources.length,
                  (index) => FadeInUp(
                    child: Center(
                      child: SizedBox(
                        width: sizeItem,
                        height: sizeItem * 1.215,
                        child: ItemGame(
                          title: resources[index].name,
                          rarity: resources[index].rarity,
                          linkImage: Config.urlImage(
                              resources[index].images?.nameicon),
                          star: true,
                          onTap: () {
                            resourceController.selectResource(resources[index]);
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
