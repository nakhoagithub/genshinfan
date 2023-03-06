import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward_preview.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';

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
    double sizeItem = Config.sizeItem2;
    List<Rewardpreview> dataRevert = domain
        .domainLvs![domain.domainLvs!.length - 1].rewardpreview.reversed
        .toList();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(sizeItem * 0.05),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ThemeApp.colorBackgroundItemInPage,
        child: Container(
          width: width,
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  "assets/images/image_dungeon.png",
                  height: sizeItem * 0.5,
                  width: sizeItem * 0.5,
                  color: ThemeApp.colorText(isDark: false),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  domain.name,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeApp.textStyle(
                      isDark: false, fontWeight: FontWeight.w500),
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
    );
  }
}

class _ItemReward extends StatelessWidget {
  final Rewardpreview reward;
  const _ItemReward({
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    Resource? resource = Tools.getResourceFromName(reward.name);
    Artifact? artifact = Tools.getArtifactFromName(reward.name);
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
              image: AssetImage(Tools.getBackgroundSquare(
                  reward.rarity ?? resource?.rarity))),
        ),
        child: CachedNetworkImage(
          imageUrl: resource != null
              ? Config.urlImage(resource.images?.nameicon)
              : artifact?.images?.flower ?? "",
          progressIndicatorBuilder: (context, url, progress) {
            return const Center(
              child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Image.asset("assets/images/icon_genshin_error.png");
          },
        ),
      ),
    );
  }
}
