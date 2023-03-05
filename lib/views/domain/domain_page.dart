import 'package:animate_do/animate_do.dart';
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
import 'package:genshinfan/views/domain/widgets/item_domain.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class DomainPage extends StatelessWidget {
  const DomainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "domain".tr,
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

class _ListDomain extends StatelessWidget {
  const _ListDomain();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    DomainController domainController = Get.find<DomainController>();
    double sizeItem = 94;
    return LayoutBuilder(builder: (p0, p1) {
      double w = p1.maxWidth;
      return Obx(() {
        List<Domain> domains = domainController.domains;
        return domains.isEmpty
            ? ListEmpty(title: "empty_domain".tr)
            : GridView.count(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: w >= 300 ? 3 : 2,
                childAspectRatio: sizeItem / (sizeItem * 1.215),
                children: List.generate(
                  domains.length,
                  (index) => FadeInUp(
                    child: Center(
                      child: SizedBox(
                        width: sizeItem,
                        height: sizeItem * 1.215,
                        child: ItemDomain(
                          domain: domains[index],
                          onTap: () {
                            Get.find<DomainController>().selectDomain(domains[index]);
                            homeController.pageCenter();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
      });
    });
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    context.theme;
    DomainController domainController = Get.find<DomainController>();
    return LayoutBuilder(
      builder: (p0, p1) {
        double w = p1.maxWidth;
        double itemWidth = 150;
        final int crossAxisCount = (w ~/ itemWidth).toInt();
        return Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 0),
            physics: const BouncingScrollPhysics(),
            itemCount: domainController.domains.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: itemWidth * 1.215,
            ),
            itemBuilder: (context, index) {
              return LayoutBuilder(
                builder: (p0, p1) {
                  return FadeInUp(
                    child: _Item(
                      domain: domainController.domains[index],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final Domain domain;
  const _Item({
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
        Get.find<HomeController>().pageCenter();
      },
      borderRadius: BorderRadius.circular(5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ThemeApp.colorBackgroundItemInPage,
        child: Container(
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
