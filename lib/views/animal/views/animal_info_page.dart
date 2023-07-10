import 'package:flutter/material.dart';
import 'package:genshinfan/views/animal/controllers/animal_controller.dart';
import 'package:genshinfan/views/animal/widgets/animal_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
import 'package:get/get.dart';

class AnimalInfoPage extends StatelessWidget {
  const AnimalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    AnimalController animalController = Get.find<AnimalController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "animal_information".tr,
          ),
        ),
        body: animalController.animal.value == null
            ? PageEmpty(title: "select_animal".tr)
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
