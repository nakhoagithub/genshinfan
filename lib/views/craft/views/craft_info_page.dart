import 'package:flutter/material.dart';
import 'package:genshinfan/views/craft/controllers/craft_controller.dart';
import 'package:genshinfan/views/craft/widgets/craft_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';

import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class CraftInfoPage extends StatelessWidget {
  const CraftInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    CraftController craftController = Get.find<CraftController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "craft_information".tr,
          ),
        ),
        body: craftController.craft.value == null
            ? PageEmpty(title: "select_craft".tr)
            : const Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationCraft(),
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
