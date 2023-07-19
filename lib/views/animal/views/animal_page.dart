import 'package:flutter/material.dart';
import 'package:genshinfan/views/app_layout.dart';
import 'package:genshinfan/views/animal/controllers/animal_controller.dart';
import 'package:genshinfan/models/game/animal.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/widgets/item.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class AnimalPage extends StatelessWidget {
  const AnimalPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return const _List();
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    AnimalController animalController = Get.find<AnimalController>();
    return Obx(() {
      List<Animal> enemies = animalController.animals;
      return enemies.isEmpty
          ? ListEmpty(title: "empty_animal".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount:
                  Get.find<AppLayoutController>().crossAxisCount(),
              childAspectRatio:
                  Get.find<AppLayoutController>().childAspectRatio(),
              children: List.generate(
                enemies.length,
                (index) => ItemGame(
                  title: enemies[index].name,
                  linkImage:
                      Config.urlImage(enemies[index].images?.nameicon),
                  onTap: () {
                    animalController.selectAnimal(enemies[index]);
                    Get.toNamed("/animal_info");
                  },
                ),
              ),
            );
    });
  }
}
