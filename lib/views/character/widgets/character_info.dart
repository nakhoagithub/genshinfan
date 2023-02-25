import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/info_element_widget.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_text_color_widget.dart';
import 'package:genshinfan/views/widgets/info_rarity_widget.dart';
import 'package:genshinfan/views/widgets/info_weapon_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:get/get.dart';
import '../../../objects/character.dart';
import '../../../resources/widgets/gradient.dart';

class InformationCharacter extends StatelessWidget {
  const InformationCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CharacterController characterController = Get.find<CharacterController>();
    return Obx(() {
      Character character = characterController.character.value!;
      return Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            _ImageCharacter(
              linkImage: character.images?.icon,
              rarity: character.rarity,
              size: 150,
            ),
            Center(
              child: Text(
                character.fullname,
                textAlign: TextAlign.center,
                style: ThemeApp.textStyle(
                  isDark: Get.isDarkMode,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // title
            Center(
              child: character.title == ""
                  ? const SizedBox()
                  : Text(
                      "(${character.title})",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontSize: 14,
                      ),
                    ),
            ),

            _InformationMore(
              character: character,
            ),
          ],
        ),
      );
    });
  }
}

class _ImageCharacter extends StatelessWidget {
  final String? linkImage;
  final String? rarity;
  final double size;
  const _ImageCharacter({
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
  final Character character;
  const _InformationMore({required this.character});

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
          // nguyên tố
          InfoElementWidget(element: character.element),
          // vũ khí
          InfoWeaponWidget(weapontype: character.weapontype),

          // độ hiếm
          InfoRarityWidget(rarity: character.rarity),

          // đột phá tăng
          InfoTextColorWidget(
              titleTranslate: "substat", data: character.substat),

          // giới tính
          InfoTextWidget(
            titleTranslate: "gender",
            data: character.gender,
          ),

          // Sinh nhật
          InfoTextWidget(
              titleTranslate: "birthday",
              data: character.birthday == ""
                  ? "travelerBirthday".tr
                  : character.birthday),

          // vùng
          character.region == ""
              ? const SizedBox()
              : InfoTextColorWidget(
                  titleTranslate: "region", data: character.region),

          // thuộc - nghề nghiệp
          character.affiliation == ""
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "affiliation",
                  data: character.affiliation,
                ),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: character.description),
        ],
      ),
    );
  }
}
