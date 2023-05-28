import 'package:flutter/material.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';

class InfoWeaponWidget extends StatelessWidget {
  final String weapontype;
  const InfoWeaponWidget({
    super.key,
    required this.weapontype,
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
              "${"weapon".tr}: ",
              style: ThemeApp.textStyle(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              padding: const EdgeInsets.all(2),
              child: Image.asset(
                "${Tools.getAssetWeaponType(weapontype)}",
                height: 30,
                width: 30,
                color: Get.theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
