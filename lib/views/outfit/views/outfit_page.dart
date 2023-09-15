import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/outfit/controllers/outfit_controller.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/outfit.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class OutfitPage extends StatelessWidget {
  const OutfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    OutfitController outfitController = Get.find<OutfitController>();
    return Obx(() {
      List<Outfit> outfits = outfitController.outfits;
      return outfits.isEmpty
          ? ListEmpty(title: "empty_outfit".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                outfits.length,
                (index) {
                  return _ItemOutfit(
                    outfit: outfits[index],
                    onTap: () {
                      outfitController.selectOutfit(outfits[index]);
                      Get.toNamed("/outfit_info");
                    },
                  );
                },
              ),
            );
    });
  }
}

class _ItemOutfit extends StatelessWidget {
  final Outfit outfit;
  final VoidCallback onTap;
  const _ItemOutfit({
    required this.outfit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    Character? character = Tool.getCharacterFromName(outfit.character);
    String linkImage = (outfit.isdefault
            ? character?.images?.icon
            : Config.urlImage(outfit.images?.namecard)) ??
        "";
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Get.theme.colorScheme.onInverseSurface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(sizeItem * 0.05),
        child: Container(
          width: sizeItem,
          height: sizeItem * 1.215,
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: linkImage,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) {
                    return const CircularProgressApp();
                  },
                  errorWidget: (context, url, error) {
                    return const ImageFailure();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    outfit.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeApp.textStyle(fontWeight: FontWeight.w500),
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
