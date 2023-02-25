import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/models/traffic.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class TrafficApplication extends StatelessWidget {
  const TrafficApplication({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    Traffic? traffic = homeController.traffic.value;
    context.theme;
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: 45,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(Icons.analytics_outlined),
                  ),
                  Expanded(
                    child: Text(
                      "access_throughput".tr,
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: traffic == null
                  ? Text(
                      "...",
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontSize: 14,
                      ),
                    )
                  : Text(
                      "${"total".tr}: ${traffic.totalTraffic}\n${"this_month".tr}: ${traffic.trafficInMonth}\n${"today".tr}: ${traffic.trafficInDay}",
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontSize: 14,
                      ),
                    ),
            ),
          ],
          
        ),
      ),
    );
  }
}
