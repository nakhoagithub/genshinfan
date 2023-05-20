import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_rarity_widget.dart';
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
              const _ImageWeapon(),
              Center(
                child: Text(
                  weapon.name,
                  textAlign: TextAlign.center,
                  style: ThemeApp.textStyle(
                    fontSize: 28,
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
  const _ImageWeapon();

  @override
  Widget build(BuildContext context) {
    WeaponController weaponController = Get.find<WeaponController>();
    double size = 150;
    return Obx(() {
      Weapon weapon = weaponController.weapon.value!;
      return Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: GradientApp.getBackgroundRarity(weapon.rarity.toString()),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: weapon.images?.mihoyoIcon ??
              Config.urlImage(weapon.images?.filenameGacha),
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
    });
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
          // tấn công
          InfoTextWidget(
              titleTranslate: "attack",
              data: weapon.baseAtkValue.toStringAsFixed(0)),

          // đột phá tăng
          InfoTextWidget(
              titleTranslate: "substat", data: weapon.mainStatText ?? "..."),

          // chỉ số phụ
          InfoTextWidget(
            titleTranslate: weapon.mainStatText ?? "...",
            data: weapon.baseStatText ?? "...",
            translate: false,
          ),

          // độ hiếm
          InfoRarityWidget(rarity: weapon.rarity.toString()),

          // loại
          InfoTextWidget(titleTranslate: "type", data: weapon.weaponText),

          // tên hiệu
          InfoTextWidget(
              titleTranslate: "effectname", data: weapon.effectName ?? "..."),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: weapon.descriptionRaw),
        ],
      ),
    );
  }
}
