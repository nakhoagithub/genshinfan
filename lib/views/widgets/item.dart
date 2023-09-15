import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:get/get.dart';

class ItemGame extends StatelessWidget {
  final String title;
  final String? linkImage;
  final Widget? iconLeft;
  final String? rarity;
  final bool? star;
  final VoidCallback? onTap;
  final double? size;
  final bool noData;
  final String? contentIfNotImage;
  const ItemGame({
    super.key,
    required this.title,
    this.linkImage,
    this.iconLeft,
    this.rarity,
    this.star,
    this.onTap,
    this.size,
    this.noData = false,
    this.contentIfNotImage,
  });

  @override
  Widget build(BuildContext context) {
    double sizeItem = size ?? Get.find<LayoutController>().widthItem.value;

    return Center(
      child: noData
          ? Container(
              margin: const EdgeInsets.all(2),
              width: sizeItem,
              height: sizeItem * 1.215,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeItem * 0.05),
                  border: Border.all(color: Colors.grey, width: 2)),
            )
          : InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(sizeItem * 0.05),
              child: Container(
                margin: const EdgeInsets.all(2),
                width: sizeItem,
                height: sizeItem * 1.215,
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeItem * 0.05),
                      ),
                      child: Image.asset(
                        Tool.getBackground(rarity),
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
                              imageUrl: linkImage ?? "",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return const CircularProgressApp();
                              },
                              errorWidget: (context, url, error) {
                                return contentIfNotImage == null
                                    ? const ImageFailure()
                                    : Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const ImageFailure(size: 20),
                                            Text(
                                              contentIfNotImage!,
                                              textAlign: TextAlign.center,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: ThemeApp.textStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
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
                              title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[850],
                                fontSize: sizeItem * 0.14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // element
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        height: sizeItem * 0.3,
                        width: sizeItem * 0.3,
                        child: iconLeft ?? const SizedBox(),
                      ),
                    ),

                    // độ hiếm - rarity
                    rarity == null || star == null
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(bottom: sizeItem * 0.15),
                              child: Image.asset(
                                Tool.getRarityStar(rarity),
                                height: sizeItem * 1.215 * 0.18,
                                width: sizeItem * 0.85,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
