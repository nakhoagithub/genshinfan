import 'package:flutter/material.dart';
import 'package:genshinfan/views/geography/controllers/geography_controller.dart';
import 'package:genshinfan/views/geography/widgets/geography_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class GeographyInfoPage extends StatelessWidget {
  const GeographyInfoPage({super.key});

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
            ? PageEmpty(title: "select_geography".tr)
            : const Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
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
