import 'package:flutter/material.dart';
import 'package:genshinfan/views/namecard/controllers/namecard_controller.dart';
import 'package:genshinfan/views/namecard/widgets/namecard_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
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
            : Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: namecardController.scrollController,
                    child: const Column(
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
