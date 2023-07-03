import 'package:flutter/material.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';

class InfoRarityWidget extends StatelessWidget {
  final String rarity;
  const InfoRarityWidget({
    super.key,
    required this.rarity,
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
              "${"rarity".tr}: ",
              style: ThemeApp.textStyle(

                  // color: ThemeApp.colorTextSecond(
                  //
                  // ),
                  ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Image.asset(
              Tools.getRarityStar(rarity),
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
