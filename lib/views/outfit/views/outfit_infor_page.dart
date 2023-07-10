import 'package:flutter/material.dart';
import 'package:genshinfan/views/outfit/controllers/outfit_controller.dart';
import 'package:genshinfan/views/outfit/widgets/outfit_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
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
            : Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: outfitController.scrollController,
                    child: const Column(
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
