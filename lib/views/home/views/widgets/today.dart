import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class HomeToday extends StatelessWidget {
  const HomeToday({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Container(
      margin: const EdgeInsets.all(4),
      height: 30,
      child: Row(
        children: [
          Text(
            "${"today".tr}: ",
            style: ThemeApp.textStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(() => Text(
                "day${homeController.today}".tr,
                style: ThemeApp.textStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: InkWell(
              onTap: () {
                dialogInfo("daily_reset_time".tr);
              },
              child: const Icon(
                Icons.help_outline_rounded,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
