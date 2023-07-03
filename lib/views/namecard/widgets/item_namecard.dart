import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/namecard.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:get/get.dart';

class ItemNamecard extends StatelessWidget {
  final Namecard namecard;
  final VoidCallback onTap;
  const ItemNamecard({
    super.key,
    required this.namecard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Get.theme.colorScheme.onInverseSurface,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: Config.urlImage(namecard.images?.nameicon),
                height: 80,
                width: 100,
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (context, url, progress) {
                  return const CircularProgressApp();
                },
                errorWidget: (context, url, error) {
                  return const ImageFailure();
                },
              ),
              Expanded(
                  child: Column(
                children: [
                  Text(namecard.name,
                      style: ThemeApp.textStyle(fontWeight: FontWeight.w500)),
                  Text(
                    namecard.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeApp.textStyle(fontSize: 14),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
