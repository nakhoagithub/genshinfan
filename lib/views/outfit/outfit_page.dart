import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/outfit/controllers/outfit_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/character.dart';
import 'package:genshinfan/models/outfit.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class OutfitPage extends StatelessWidget {
  const OutfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "outfit".tr,
            width: double.infinity,
          ),
          const Expanded(
            child: _List(),
          )
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    OutfitController outfitController = Get.find<OutfitController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem2;
    return Obx(() {
      List<Outfit> outfits = outfitController.outfits;
      return outfits.isEmpty
          ? ListEmpty(title: "empty_outfit".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio: sizeItem / (sizeItem * 1.215),
              children: List.generate(
                outfits.length,
                (index) {
                  return FadeInUp(
                    child: Center(
                      child: SizedBox(
                        width: sizeItem,
                        height: sizeItem * 1.215,
                        child: _ItemOutfit(
                          outfit: outfits[index],
                          onTap: () {
                            outfitController.selectOutfit(outfits[index]);
                            homeController.pageCenter();
                          },
                        ),
                      ),
                    ),
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
    double sizeItem = Config.sizeItem2;
    Character? character = Tools.getCharacterFromName(outfit.character);
    String linkImage = (outfit.isdefault
            ? character?.images?.icon
            : Config.urlImage(outfit.images?.namecard)) ??
        "";
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(sizeItem * 0.05),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Get.theme.colorScheme.onInverseSurface,
        child: Container(
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeApp.textStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
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
