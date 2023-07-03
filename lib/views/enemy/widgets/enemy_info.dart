import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/enemy/controllers/enemy_controller.dart';
import 'package:genshinfan/models/enemy.dart';
import 'package:genshinfan/models/reward.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_reward_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:get/get.dart';

class InformationEnemy extends StatelessWidget {
  const InformationEnemy({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    EnemyController enemyController = Get.find<EnemyController>();
    return Obx(() {
      Enemy enemy = enemyController.enemy.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageEnemy(
                linkImage: Config.urlImage(enemy.images?.nameicon),
                rarity: "1",
                size: 150,
              ),
              Center(
                child: Text(
                  enemy.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _InformationMore(
                enemy: enemy,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageEnemy extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageEnemy({
    required this.linkImage,
    required this.rarity,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: GradientApp.getBackgroundRarity(rarity),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: linkImage ?? "",
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          return const CircularProgressApp();
        },
        errorWidget: (context, url, error) {
          return const ImageFailure();
        },
      ),
    );
  }
}

class _InformationMore extends StatelessWidget {
  final Enemy enemy;
  const _InformationMore({required this.enemy});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Reward> dataRevert = enemy.rewardpreview.reversed.toList();
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // tên đặc biệt
          InfoTextWidget(
              titleTranslate: "specialname", data: enemy.specialname),

          // type
          InfoTextWidget(titleTranslate: "type", data: enemy.enemytype),

          // substat
          InfoTextWidget(titleTranslate: "substat", data: enemy.category),

          // description
          InfoParagraphWidget(
              titleTranslate: "description", data: enemy.description),

          // reward
          dataRevert.isEmpty
              ? const SizedBox()
              : InfoRewardWidget(titleTranslate: "reward", data: dataRevert),
        ],
      ),
    );
  }
}
