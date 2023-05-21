import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/animal_controller.dart';

import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/animal/widgets/animal_info.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class AnimalScreen extends StatelessWidget {
  const AnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AnimalController animalController = Get.find<AnimalController>();

    return Obx(() {
      return Scaffold(
        // backgroundColor: ThemeApp.colorCard(),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "animal_information".tr,
          ),
        ),
        body: animalController.animal.value == null
            ? PageEmpty(title: "choose_animal".tr)
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: animalController.scrollController,
                    child: const Column(
                      children: [
                        InformationAnimal(),
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