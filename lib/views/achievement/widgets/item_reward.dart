import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/namecard.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:get/get.dart';

class ItemRewardAchievementGroup extends StatelessWidget {
  final Namecard? namecard;
  const ItemRewardAchievementGroup({super.key, required this.namecard});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "reward".tr,
          style: ThemeApp.textStyle(),
        ),
        CachedNetworkImage(
          imageUrl: Config.urlImage(namecard?.images?.nameicon),
          height: 100,
          width: 140,
          fit: BoxFit.fitWidth,
          progressIndicatorBuilder: (context, url, progress) {
            return const CircularProgressApp();
          },
          errorWidget: (context, url, error) {
            return const ImageFailure();
          },
        ),
      ],
    );
  }
}
