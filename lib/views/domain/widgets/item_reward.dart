import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';

class ItemReward extends StatelessWidget {
  final Resource? resource;
  final Artifact? artifact;
  final String? rarity;
  final String name;
  final VoidCallback onTap;
  const ItemReward({
    super.key,
    required this.resource,
    required this.artifact,
    this.rarity,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double sizeItem = Config.sizeItem3;
    return InkWell(
      onTap: () {
        if (resource != null) {
          Get.find<ResourceController>().selectResource(resource!);
          Get.toNamed('/resource_info');
        } else if (artifact != null) {
          // xem thông tin thánh di vật
          Get.find<ArtifactController>().selectArtifact(artifact!);
          Get.toNamed('/artifact_info');
        }
      },
      borderRadius: BorderRadius.circular(sizeItem * 0.05),
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
                borderRadius: BorderRadius.circular(sizeItem * 0.05),
              ),
              child: Image.asset(
                Tools.getBackground(rarity ?? resource?.rarity),
                fit: BoxFit.cover,
                height: sizeItem * 1.215,
                width: sizeItem,
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
                        bottomRight: Radius.circular(sizeItem * 0.2),
                        topLeft: Radius.circular(sizeItem * 0.05),
                        topRight: Radius.circular(sizeItem * 0.05),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: resource != null
                          // ảnh resource
                          ? Config.urlImage(resource?.images?.nameicon ?? "")
                          // ảnh của artifact
                          : artifact?.images?.flower ?? "",
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) {
                        return const Center(
                          child: SizedBox(
                            height: 16,
                            width: 16,
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
                ),

                // name
                Container(
                  height: sizeItem * 0.205,
                  width: sizeItem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(sizeItem * 0.05),
                      bottomRight: Radius.circular(sizeItem * 0.05),
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
                        fontSize: sizeItem * 0.16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // độ hiếm - rarity
            resource?.rarity == null
                ? const SizedBox()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Image.asset(
                        Tools.getRarityStar(resource!.rarity!),
                        height: sizeItem * 0.2,
                        width: sizeItem * 0.2,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
