import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_rarity_widget.dart';
import 'package:genshinfan/views/widgets/info_text_color_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:get/get.dart';
import '../../../objects/weapon.dart';

class InformationWeapon extends StatelessWidget {
  const InformationWeapon({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WeaponController weaponController = Get.find<WeaponController>();
    return Obx(() {
      Weapon weapon = weaponController.weapon.value!;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              _ImageWeapon(
                linkImage: weapon.images?.icon,
                rarity: weapon.rarity,
                size: 150,
              ),
              Center(
                child: Text(
                  weapon.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    isDark: Get.isDarkMode,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _InformationMore(
                weapon: weapon,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ImageWeapon extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageWeapon({
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
    );
  }
}

class _InformationMore extends StatelessWidget {
  final Weapon weapon;
  const _InformationMore({required this.weapon});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // đột phá tăng
          InfoTextWidget(titleTranslate: "attack", data: "${weapon.baseatk}"),

          // độ hiếm
          InfoRarityWidget(rarity: weapon.rarity),

          // loại
          InfoTextWidget(titleTranslate: "type", data: weapon.weapontype),

          // đột phá tăng
          InfoTextColorWidget(titleTranslate: "substat", data: weapon.substat),

          // tên hiệu
          InfoTextWidget(titleTranslate: "effectname", data: weapon.effectname),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: weapon.description),
        ],
      ),
    );
  }
}
