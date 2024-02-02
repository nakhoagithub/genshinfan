import 'package:flutter/material.dart';
import 'package:genshinfan/src/animal/controllers/animal_controller.dart';
import 'package:genshinfan/src/animal/widgets/animal_info.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
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
            : const Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
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
