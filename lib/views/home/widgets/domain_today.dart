import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward_preview.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:get/get.dart';

class ListDomainToday extends StatelessWidget {
  const ListDomainToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    HomeController homeController = Get.find<HomeController>();
    List<Domain> domains =
        homeController.getDomainToday("day${homeController.today}".tr) ?? [];
    return Container(
      margin: const EdgeInsets.all(4),
      height: (132 * 1.215) + 20,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: domains.length,
        itemBuilder: (context, index) {
          return _ItemDomainToday(domain: domains[index]);
        },
      ),
    );
  }
}

class _ItemDomainToday extends StatelessWidget {
  final Domain domain;
  const _ItemDomainToday({
    required this.domain,
  });

  @override
  Widget build(BuildContext context) {
    List<Rewardpreview> dataRevert = domain
        .domainLvs![domain.domainLvs!.length - 1].rewardpreview.reversed
        .toList();
    return InkWell(
      onTap: () {
        Get.find<DomainController>().selectDomain(domain);
        Get.toNamed('/domain_info');
      },
      borderRadius: BorderRadius.circular(5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ThemeApp.colorBackgroundItemInPage,
        child: Container(
          width: 132,
          height: 132 * 1.215,
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  "assets/images/image_dungeon.png",
                  height: 50,
                  width: 50,
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
          gradient: GradientApp.getBackgroundRarity(
              reward.rarity ?? resource?.rarity),
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
