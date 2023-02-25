import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';

class ItemAscendWeapon extends StatelessWidget {
  final Resource resource;
  final int count;
  const ItemAscendWeapon({
    super.key,
    required this.resource,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    double sizeItem = 70;
    return Center(
      child: InkWell(
        onTap: () {
          ResourceController resourceController =
              Get.find<ResourceController>();
          resourceController.selectResource(resource);
          Get.toNamed('/resource_info');
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          margin: const EdgeInsets.all(2),
          width: sizeItem,
          height: sizeItem * 1.215,
          child: Stack(
            children: [
              // background
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  Tools.getBackground(resource.rarity),
                  fit: BoxFit.cover,
                  height: sizeItem * 1.215,
                  width: sizeItem,
                ),
              ),

              // image, name
              Column(
                children: [
                  Container(
                    height: sizeItem * 1.215 * 0.82,
                    width: sizeItem,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: Config.urlImage(resource.images?.nameicon),
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
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            color: Colors.black54,
                            size: 16,
                          ),
                        );
                      },
                    ),
                  ),

                  // count
                  Container(
                    height: sizeItem * 1.215 * 0.15,
                    width: sizeItem,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "$count",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: sizeItem * 0.15),
                  child: resource.rarity != null
                      ? Image.asset(
                          Tools.getRarityStar(resource.rarity!),
                          height: sizeItem * 1.215 * 0.18,
                          width: sizeItem * 0.85,
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
