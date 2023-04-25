import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class InfoTextWidget extends StatelessWidget {
  final String titleTranslate;
  final String data;
  const InfoTextWidget({
    super.key,
    required this.titleTranslate,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Config.marginText),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "${titleTranslate.tr}: ",
              style: ThemeApp.textStyle(

                  // color: ThemeApp.colorTextSecond(
                  //
                  // ),
                  ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              data,
              textAlign: TextAlign.center,
              style: ThemeApp.textStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
