import 'package:flutter/material.dart';
import 'package:genshinfan/src/animal/controllers/animal_controller.dart';
import 'package:genshinfan/models/game/animal.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:genshinfan/src/widgets/list_empty.dart';
import 'package:get/get.dart';

class AnimalPage extends StatelessWidget {
  const AnimalPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("animal".tr),
      ),
      body: const _List(),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    AnimalController animalController = Get.find<AnimalController>();
    return Obx(() {
      List<Animal> animals = animalController.animals;
      return animals.isEmpty
          ? ListEmpty(title: "empty_animal".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: Get.find<LayoutController>().crossAxisCount.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio.value,
              children: List.generate(
                animals.length,
                (index) => ItemGame(
                  title: animals[index].name,
                  linkImage: Config.urlImage(animals[index].images?.nameicon),
                  onTap: () {
                    animalController.selectAnimal(animals[index]);
                    Get.toNamed("/animal_info");
                  },
                ),
              ),
            );
    });
  }
}
