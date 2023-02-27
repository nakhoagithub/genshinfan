import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/views/resource/widgets/item_resource.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
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
            onTapAction: () {},
          ),
          const Expanded(child: _ListResource()),
        ],
      ),
    );
  }
}

class _ListResource extends StatelessWidget {
  const _ListResource();

  @override
  Widget build(BuildContext context) {
    ResourceController resourceController = Get.find<ResourceController>();
    double sizeItem = 94;
    return LayoutBuilder(builder: (p0, p1) {
      double w = p1.maxWidth;
      return GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: w >= 300 ? 3 : 2,
        childAspectRatio: sizeItem / (sizeItem * 1.215),
        children: List.generate(
          resourceController.resources.length,
          (index) => FadeInUp(
            child: Center(
              child: SizedBox(
                width: sizeItem,
                height: sizeItem * 1.215,
                child: ItemResource(
                  resource: resourceController.resources[index],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
