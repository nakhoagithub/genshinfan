import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeTool extends StatelessWidget {
  const HomeTool({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Wrap(
        children: [
          Text(
            "tool".tr,
            style: ThemeApp.textStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton.icon(
                icon: Image.asset(
                  "assets/images/UI_HomeWorldTabIcon_2_Teleport.png",
                  color: Get.theme.colorScheme.onSurface,
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  Get.find<HomeController>().openGenshinMap();
                },
                label: Text("genshin_map".tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
