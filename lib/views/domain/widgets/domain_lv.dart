import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/views/domain/widgets/item_reward.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:get/get.dart';

class InformationDomainLv extends StatelessWidget {
  const InformationDomainLv({super.key});

  @override
  Widget build(BuildContext context) {
    DomainController domainController = Get.find<DomainController>();
    return Obx(() {
      Domain domain = domainController.domain.value!;
      return domain.domainLvs == null
          ? const SizedBox()
          : Column(
              children: [
                ...domain.domainLvs!.map((e) {
                  return _ItemDomain(
                    domainLv: e,
                  );
                }),
              ],
            );
    });
  }
}

class _ItemDomain extends StatelessWidget {
  final DomainLv domainLv;
  const _ItemDomain({
    required this.domainLv,
  });

  @override
  Widget build(BuildContext context) {
    List<Reward> dataRevert = domainLv.rewardpreview.reversed.toList();
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          strokeAlign: 1,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image domain
                Container(
                  margin: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/images/image_dungeon.png",
                    height: 40,
                    width: 40,
                    // color: ThemeApp.colorText(),
                  ),
                ),
                Expanded(
                  child: Text(
                    domainLv.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // recommendedlevel
            Row(
              children: [
                Text(
                  "${"recommendedlevel".tr}: ",
                  style: ThemeApp.textStyle(),
                ),
                Text(
                  "${domainLv.recommendedlevel}",
                  style: ThemeApp.textStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // unlockrank
            Row(
              children: [
                Text(
                  "${"unlockrank".tr}: ",
                  style: ThemeApp.textStyle(),
                ),
                Text(
                  "${domainLv.unlockrank}",
                  style: ThemeApp.textStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // recommendedelements
            domainLv.recommendedelements.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      Text(
                        "${"recommendedelements".tr}: ",
                        style: ThemeApp.textStyle(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              ...domainLv.recommendedelements.map((e) {
                                return Image.asset(
                                  Tools.getAssetElementFromName(e),
                                  height: 30,
                                  width: 30,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

            // disorder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"disorder".tr}: ",
                  style: ThemeApp.textStyle(),
                ),
                ...domainLv.disorder.map(
                  (e) {
                    return Text(
                      "- $e",
                      style: ThemeApp.textStyle(),
                    );
                  },
                ),
              ],
            ),

            // reward
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"reward".tr}: ",
                  style: ThemeApp.textStyle(),
                ),
                SizedBox(
                  height: Get.width * 0.25,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: dataRevert.length,
                    itemBuilder: (context, index) {
                      Resource? resource =
                          Tools.getResourceFromName(dataRevert[index].name);
                      Artifact? artifact =
                          Tools.getArtifactFromName(dataRevert[index].name);
                      return Center(
                        child: ItemReward(
                          size: Get.width * 0.18,
                          resource: resource,
                          artifact: artifact,
                          rarity: dataRevert[index].rarity,
                          name: dataRevert[index].name,
                          onTap: () {
                            if (resource != null) {
                              Get.find<ResourceController>()
                                  .selectResource(resource);
                              Get.toNamed('/resource_info');
                            } else if (artifact != null) {
                              // xem thông tin thánh di vật
                              Get.find<ArtifactController>()
                                  .selectArtifact(artifact);
                              Get.toNamed('/artifact_info');
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // monster
            domainLv.monsterlist == null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${"monster".tr}: ",
                        style: ThemeApp.textStyle(),
                      ),
                      SizedBox(
                        height: Get.width * 0.25,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: domainLv.monsterlist!.length,
                          itemBuilder: (context, index) {
                            Enemy? enemy = Tools.getEnemyFromName(
                                domainLv.monsterlist![index]);
                            return enemy == null
                                ? const SizedBox()
                                : Center(
                                    child: ItemGame(
                                      size: Get.width * 0.18,
                                      title: enemy.name,
                                      linkImage: Config.urlImage(
                                          enemy.images?.nameicon),
                                      onTap: () {},
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
