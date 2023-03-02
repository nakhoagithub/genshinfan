import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/reward_preview.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
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
    List<Rewardpreview> dataRevert = domainLv.rewardpreview.reversed.toList();
    return Container(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          strokeAlign: 1,
          color: ThemeApp.colorText(isDark: Get.isDarkMode),
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
                    color: ThemeApp.colorText(isDark: Get.isDarkMode),
                  ),
                ),
                Expanded(
                  child: Text(
                    domainLv.name,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      fontSize: 18,
                      isDark: Get.isDarkMode,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // image
            Container(
              margin: const EdgeInsets.all(4),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: Config.urlImage(domainLv.images?.namepic),
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return const Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.black54,
                      size: 20,
                    ),
                  );
                },
              ),
            ),

            // recommendedlevel
            Row(
              children: [
                Text(
                  "${"recommendedlevel".tr}: ",
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                    color: ThemeApp.colorTextSecond(
                      isDark: Get.isDarkMode,
                    ),
                  ),
                ),
                Text(
                  "${domainLv.recommendedlevel}",
                  style: ThemeApp.textStyle(
                      isDark: Get.isDarkMode, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // unlockrank
            Row(
              children: [
                Text(
                  "${"unlockrank".tr}: ",
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                    color: ThemeApp.colorTextSecond(
                      isDark: Get.isDarkMode,
                    ),
                  ),
                ),
                Text(
                  "${domainLv.unlockrank}",
                  style: ThemeApp.textStyle(
                      isDark: Get.isDarkMode, fontWeight: FontWeight.bold),
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
                        style: ThemeApp.textStyle(
                          isDark: Get.isDarkMode,
                          color: ThemeApp.colorTextSecond(
                            isDark: Get.isDarkMode,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              ...domainLv.recommendedelements.map((e) {
                                return Image.asset(
                                  Tools.getElementFromName(e) ?? "",
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
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                    color: ThemeApp.colorTextSecond(
                      isDark: Get.isDarkMode,
                    ),
                  ),
                ),
                ...domainLv.disorder.map(
                  (e) {
                    return Text(
                      "- $e",
                      style: ThemeApp.textStyle(isDark: Get.isDarkMode),
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
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                    color: ThemeApp.colorTextSecond(
                      isDark: Get.isDarkMode,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
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
                      return _ItemReward(
                        resource: resource,
                        artifact: artifact,
                        rarity: dataRevert[index].rarity,
                        name: dataRevert[index].name,
                      );
                    },
                  ),
                ),
              ],
            ),

            // monster
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"monster".tr}: ",
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                    color: ThemeApp.colorTextSecond(
                      isDark: Get.isDarkMode,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: domainLv.monsterlist.length,
                    itemBuilder: (context, index) {
                      Enemy? enemy =
                          Tools.getEnemyFromName(domainLv.monsterlist[index]);
                      return enemy == null
                          ? const SizedBox()
                          : _ItemMonster(
                              enemy: enemy,
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

class _ItemReward extends StatelessWidget {
  final Resource? resource;
  final Artifact? artifact;
  final String? rarity;
  final String name;
  const _ItemReward({
    required this.resource,
    required this.artifact,
    required this.rarity,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    double height = 70;
    double width = height / 1.215;
    return Center(
      child: InkWell(
        onTap: () {
          if (resource != null) {
            Get.find<ResourceController>().selectResource(resource!);
            Get.toNamed('/resource_info');
          } else if (artifact != null) {
            // xem thông tin thánh di vật
            Get.find<ArtifactController>().selectArtifact(artifact!);
            Get.toNamed('/artifact_info');
          }
        },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: height,
          width: width,
          child: Stack(
            children: [
              // background
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.055),
                ),
                child: Image.asset(
                  Tools.getBackground(rarity ?? resource?.rarity),
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),

              // image, name
              Column(
                children: [
                  Expanded(
                    // image
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(height * 0.165),
                          topLeft: Radius.circular(height * 0.05),
                          topRight: Radius.circular(height * 0.05),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: resource != null
                            // ảnh resource
                            ? Config.urlImage(resource?.images?.nameicon ?? "")
                            // ảnh của artifact
                            : artifact?.images?.flower ?? "",
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported_rounded,
                              color: Colors.black54,
                              size: height * 0.12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // name
                  Container(
                    height: height - height * 0.84,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(height * 0.05),
                        bottomRight: Radius.circular(height * 0.05),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: height * 0.13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // star resource
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.68),
                child: resource?.rarity != null
                    ? Image.asset(
                        Tools.getRarityStar(resource!.rarity!),
                        height: height * 0.2,
                        width: height * 0.2,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemMonster extends StatelessWidget {
  final Enemy enemy;
  const _ItemMonster({
    required this.enemy,
  });

  @override
  Widget build(BuildContext context) {
    double height = 70;
    double width = height / 1.215;
    return Center(
      child: InkWell(
        onTap: () {
          Get.find<EnemyController>().selectEnemy(enemy);
          Get.toNamed('/enemy_info');
        },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: height,
          width: width,
          child: Stack(
            children: [
              // background
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.055),
                ),
                child: Image.asset(
                  Tools.getBackground("1"),
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),

              // image, name
              Column(
                children: [
                  Expanded(
                    // image
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(height * 0.165),
                          topLeft: Radius.circular(height * 0.05),
                          topRight: Radius.circular(height * 0.05),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: Config.urlImage(enemy.images?.nameicon),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported_rounded,
                              color: Colors.black54,
                              size: height * 0.12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // name
                  Container(
                    height: height - height * 0.84,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(height * 0.05),
                        bottomRight: Radius.circular(height * 0.05),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        enemy.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: height * 0.13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
