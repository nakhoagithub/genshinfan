import 'package:flutter/material.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/windglider/controllers/windglider_controller.dart';
import 'package:genshinfan/src/windglider/widgets/windglider_info.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class WindgliderInfoPage extends StatelessWidget {
  const WindgliderInfoPage({super.key});

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
            : const Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
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
