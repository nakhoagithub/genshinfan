import 'package:flutter/material.dart';
import 'package:genshinfan/views/resource/controllers/resource_controller.dart';
import 'package:genshinfan/views/resource/widgets/resource_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class ResourceInfoPage extends StatelessWidget {
  const ResourceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ResourceController resourceController = Get.find<ResourceController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "resource_information".tr,
          ),
        ),
        body: resourceController.resource.value == null
            ? PageEmpty(title: "select_resource".tr)
            : Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: resourceController.scrollController,
                    child: const Column(
                      children: [
                        InformationResource(),
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