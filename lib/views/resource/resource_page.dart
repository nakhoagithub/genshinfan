import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/views/resource/widgets/item_resource.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
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
                          child: ItemResource(
                            resource: resources[index],
                            onTap: () {
                              resourceController
                                  .selectResource(resources[index]);
                              homeController.pageCenter();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
    });
  }
}
