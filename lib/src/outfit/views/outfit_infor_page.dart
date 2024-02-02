import 'package:flutter/material.dart';
import 'package:genshinfan/src/outfit/controllers/outfit_controller.dart';
import 'package:genshinfan/src/outfit/widgets/outfit_info.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class OutfitInfoPage extends StatelessWidget {
  const OutfitInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    OutfitController outfitController = Get.find<OutfitController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "outfit_information".tr,
          ),
        ),
        body: outfitController.outfit.value == null
            ? PageEmpty(title: "select_outfit".tr)
            : const Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationOutfit(),
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
