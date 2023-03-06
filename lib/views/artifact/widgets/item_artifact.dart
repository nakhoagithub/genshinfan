import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';

class ItemArtifact extends StatelessWidget {
  final Artifact artifact;

  /// `1`: bông
  /// `2`: lông
  /// `3`: đồng hồ
  /// `4`: ly
  /// `5`: nón
  final int? viewType;
  final VoidCallback onTap;
  const ItemArtifact({
    super.key,
    required this.artifact,
    this.viewType,
    required this.onTap,
  });

  String linkImageWithType() {
    switch (viewType) {
      case 1:
        return artifact.images?.flower ?? "";
      case 2:
        return artifact.images?.plume ?? "";
      case 3:
        return artifact.images?.sands ?? "";
      case 4:
        return artifact.images?.goblet ?? "";
      case 5:
        return artifact.images?.circlet ?? "";
    }
    return artifact.images?.flower ?? artifact.images?.circlet ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double sizeItem = Config.sizeItem3;
    return InkWell(
      onTap: onTap,
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
                Tools.getBackground(
                    artifact.rarity[artifact.rarity.length - 1]),
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
                      imageUrl: linkImageWithType(),
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
                      artifact.name,
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
          ],
        ),
      ),
    );
  }
}
