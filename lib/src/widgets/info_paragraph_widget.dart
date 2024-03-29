import 'package:flutter/material.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:get/get.dart';

class InfoParagraphWidget extends StatelessWidget {
  final String titleTranslate;
  final String data;
  const InfoParagraphWidget({
    super.key,
    required this.titleTranslate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: Config.marginText),
          child: Text(
            "${titleTranslate.tr}: ",
            style: ThemeApp.textStyle(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          child: Text(
            data,
            style: ThemeApp.textStyle(),
          ),
        ),
      ],
    );
  }
}
