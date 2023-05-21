import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/circular_progress.dart';
import 'package:genshinfan/views/widgets/gradient.dart';
import 'package:genshinfan/views/widgets/image_failure.dart';
import 'package:genshinfan/views/widgets/info_element_widget.dart';
import 'package:genshinfan/views/widgets/info_paragraph_widget.dart';
import 'package:genshinfan/views/widgets/info_rarity_widget.dart';
import 'package:genshinfan/views/widgets/info_weapon_widget.dart';
import 'package:genshinfan/views/widgets/info_text_widget.dart';
import 'package:get/get.dart';

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
              linkImage: character.images?.mihoyoIcon,
              rarity: character.rarity.toString(),
              size: 150,
            ),
            Center(
              child: Text(
                character.fullname ?? character.name,
                textAlign: TextAlign.center,
                style: ThemeApp.textStyle(
                  fontSize: 28,
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
  final String rarity;
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
          InfoElementWidget(element: character.elementType),
          // vũ khí
          InfoWeaponWidget(weaponType: character.weaponType),

          // độ hiếm
          InfoRarityWidget(rarity: character.rarity.toString()),

          // đột phá tăng
          InfoTextWidget(
              titleTranslate: "substat", data: character.substatText),

          // giới tính
          InfoTextWidget(
            titleTranslate: "gender",
            data: character.gender,
          ),

          // Sinh nhật
          InfoTextWidget(
              titleTranslate: "birthday",
              data: character.birthday == "" ? "..." : character.birthday),

          // vùng
          character.region == ""
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "region", data: character.region),

          // thuộc - nghề nghiệp
          character.affiliation == ""
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "affiliation",
                  data: character.affiliation,
                ),

          // cung mệnh
          character.constellation == ""
              ? const SizedBox()
              : InfoTextWidget(
                  titleTranslate: "constellation",
                  data: character.constellation,
                ),

          // mô tả
          InfoParagraphWidget(
              titleTranslate: "description", data: character.description),
        ],
      ),
    );
  }
}
