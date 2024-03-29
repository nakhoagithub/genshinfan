import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/models/game/reward.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/circular_progress.dart';
import 'package:get/get.dart';

class ItemDomain extends StatelessWidget {
  final Domain domain;
  final VoidCallback onTap;
  final double? width;
  const ItemDomain({
    super.key,
    required this.domain,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = width ?? Get.find<LayoutController>().widthItem.value;
    List<Reward> dataRevert = domain
        .domainLvs![domain.domainLvs!.length - 1].rewardpreview.reversed
        .toList();
    return Center(
      child: Card(
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
                  flex: 1,
                  child: Image.asset(
                    "assets/images/image_dungeon.png",
                    height: sizeItem * 0.5,
                    width: sizeItem * 0.5,
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    domain.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeApp.textStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                domain.domainLvs == null
                    ? const SizedBox()
                    : Expanded(
                        flex: 1,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: dataRevert.length,
                          itemBuilder: (context, index) {
                            return _ItemReward(
                              reward: dataRevert[index],
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemReward extends StatelessWidget {
  final Reward reward;
  const _ItemReward({
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    Resource? resource = Tool.getResourceFromName(reward.name);
    Artifact? artifact = Tool.getArtifactFromName(reward.name);
    return Center(
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(2),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(10),
          ),
          // gradient: GradientApp.getBackgroundRarity(
          //     reward.rarity ?? resource?.rarity),
          image: DecorationImage(
              image: AssetImage(
                  Tool.getBackgroundSquare(reward.rarity ?? resource?.rarity))),
        ),
        child: CachedNetworkImage(
          imageUrl: resource != null
              ? resource.images?.redirect ?? ""
              : artifact?.images?.flower ?? "",
          progressIndicatorBuilder: (context, url, progress) {
            return const CircularProgressApp();
          },
          errorWidget: (context, url, error) {
            return Image.asset("assets/images/icon_genshin_error.png");
          },
        ),
      ),
    );
  }
}
