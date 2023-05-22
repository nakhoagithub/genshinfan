import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/windglider_controller.dart';

import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/windglider/widgets/windglider_info.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class WindgliderScreen extends StatelessWidget {
  const WindgliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    WindgliderController windgliderController =
        Get.find<WindgliderController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "windglider_information".tr,
          ),
        ),
        body: windgliderController.windglider.value == null
            ? PageEmpty(title: "select_windglider".tr)
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: windgliderController.scrollController,
                    child: const Column(
                      children: [
                        InformationWindglider(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
