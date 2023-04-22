import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward_preview.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';

class InfoRewardWidget extends StatelessWidget {
  final String titleTranslate;
  final List<Rewardpreview> data;
  const InfoRewardWidget({
    super.key,
    required this.titleTranslate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${"reward".tr}: ",
          style: ThemeApp.textStyle(
            isDark: Get.isDarkMode,
            // color: ThemeApp.colorTextSecond(
            //   isDark: Get.isDarkMode,
            // ),
          ),
        ),
        SizedBox(
          height: 80,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                ...data.map(
                  (e) {
                    Resource? resource = Tools.getResourceFromName(e.name);
                    return resource == null
                        ? const SizedBox()
                        : _ItemResource(resource: resource, name: e.name);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemResource extends StatelessWidget {
  final Resource resource;
  final String name;
  const _ItemResource({
    required this.resource,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    double height = 70;
    double width = height / 1.215;
    return Center(
      child: InkWell(
        onTap: () {
          ResourceController resourceController =
              Get.find<ResourceController>();
          resourceController.selectResource(resource);
          Get.toNamed('/resource_info');
        },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: height,
          width: width,
          child: Stack(
            children: [
              // background
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.055),
                ),
                child: Image.asset(
                  Tools.getBackground(resource.rarity),
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),

              // image, name
              Column(
                children: [
                  Expanded(
                    // image
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(height * 0.165),
                          topLeft: Radius.circular(height * 0.05),
                          topRight: Radius.circular(height * 0.05),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            Config.urlImage(resource.images?.nameicon ?? ""),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported_rounded,
                              color: Colors.black54,
                              size: height * 0.12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // name
                  Container(
                    height: height - height * 0.84,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(height * 0.05),
                        bottomRight: Radius.circular(height * 0.05),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: height * 0.13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // star resource
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.68),
                child: resource.rarity != null
                    ? Image.asset(
                        Tools.getRarityStar(resource.rarity!),
                        height: height * 0.2,
                        width: height * 0.2,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
