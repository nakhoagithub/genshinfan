import 'package:flutter/material.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';

class InfoMultiRarityWidget extends StatelessWidget {
  final List<String> rarities;
  const InfoMultiRarityWidget({
    super.key,
    required this.rarities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Config.marginText),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Column(
              children: [
                ...rarities.map(
                  (e) {
                    return Image.asset(
                      Tool.getRarityStar(e),
                      height: 20,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
