import 'package:flutter/material.dart';
import 'package:genshinfan/src/namecard/controllers/namecard_controller.dart';
import 'package:genshinfan/src/namecard/widgets/namecard_info.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class NamecardInfoPage extends StatelessWidget {
  const NamecardInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    NamecardController namecardController = Get.find<NamecardController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "namecard_information".tr,
          ),
        ),
        body: namecardController.namecard.value == null
            ? PageEmpty(title: "select_namecard".tr)
            : const Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationNamecard(),
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
