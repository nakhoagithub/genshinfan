import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/objects/app/traffic.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class TrafficApplication extends StatelessWidget {
  const TrafficApplication({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();

    context.theme;
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Obx(() {
          Traffic? traffic = homeController.traffic.value;
          return Column(
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
                        style: ThemeApp.textStyle(),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await dialogConfirm(
                            "notification".tr, "refresh_traffic".tr, () async {
                          dialogProgress("checking".tr);
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          await Get.find<HomeController>().getTraffic();
                          Get.back();
                        });
                      },
                      child: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: traffic == null
                    ? Text(
                        "...",
                        style: ThemeApp.textStyle(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Container(
                          //       height: 10,
                          //       width: 10,
                          //       decoration: const BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: Colors.green,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 4),
                          //     Text(
                          //       "${"online".tr}: ${traffic.online}",
                          //       style: ThemeApp.textStyle(),
                          //     )
                          //   ],
                          // ),
                          Text(
                            "${"total".tr}: ${traffic.totalTraffic}",
                            style: ThemeApp.textStyle(),
                          ),
                          Text(
                            "${"this_month".tr}: ${traffic.trafficInMonth}",
                            style: ThemeApp.textStyle(),
                          ),
                          Text(
                            "${"today".tr}: ${traffic.trafficInDay}",
                            style: ThemeApp.textStyle(),
                          ),
                        ],
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
