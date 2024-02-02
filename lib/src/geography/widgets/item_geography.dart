import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/geography.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/widgets/circular_progress.dart';
import 'package:genshinfan/src/widgets/image_failure.dart';
import 'package:get/get.dart';

class ItemGeography extends StatelessWidget {
  final Geography geography;
  final VoidCallback onTap;
  const ItemGeography({
    super.key,
    required this.geography,
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
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(geography.name,
                    style: ThemeApp.textStyle(fontWeight: FontWeight.w500)),
              ),
              CachedNetworkImage(
                imageUrl: Config.urlImage(geography.images?.nameimage),
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return const CircularProgressApp();
                },
                errorWidget: (context, url, error) {
                  return const ImageFailure();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
