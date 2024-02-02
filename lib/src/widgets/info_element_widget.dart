import 'package:flutter/material.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';

class InfoElementWidget extends StatelessWidget {
  final String element;
  const InfoElementWidget({
    super.key,
    required this.element,
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
              "${"element".tr}: ",
              style: ThemeApp.textStyle(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Tool.getAssetElementFromName(element) == ""
                ? Text(
                    'especially'.tr,
                    textAlign: TextAlign.center,
                    style: ThemeApp.textStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[700],
                    ),
                  )
                : Image.asset(
                    Tool.getAssetElementFromName(element),
                    height: 30,
                    width: 30,
                  ),
          ),
        ],
      ),
    );
  }
}
