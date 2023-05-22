import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/geography_controller.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/geography/widgets/geography_info.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class GeographyScreen extends StatelessWidget {
  const GeographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    GeographyController geographyController = Get.find<GeographyController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "geography_information".tr,
          ),
        ),
        body: geographyController.geography.value == null
            ? PageEmpty(title: "choose_geography".tr)
            : Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: geographyController.scrollController,
                    child: const Column(
                      children: [
                        InformationGeography(),
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
