import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/resource/controllers/resource_controller.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:get/get.dart';

class ListResource extends StatelessWidget {
  final List<Resource> resources;
  const ListResource({super.key, required this.resources});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return resources.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "resource".tr,
                      style: ThemeApp.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: resources.length,
                      itemBuilder: (context, index) {
                        return Center(
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
                                Get.find<ResourceController>()
                                    .selectResource(resources[index]);
                                Get.toNamed("/resource_info");
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
