import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/animal.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/animal/controllers/animal_controller.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/widgets/item.dart';
import 'package:get/get.dart';

class ListAnimal extends StatelessWidget {
  final List<Animal> animals;
  const ListAnimal({super.key, required this.animals});

  @override
  Widget build(BuildContext context) {
    context.theme;
    double sizeItem = Get.find<LayoutController>().widthItem.value;
    return animals.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "animal".tr,
                      style: ThemeApp.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: animals.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SizedBox(
                            width: sizeItem,
                            height: sizeItem * 1.215,
                            child: ItemGame(
                              title: animals[index].name,
                              linkImage: Config.urlImage(
                                  animals[index].images?.nameicon),
                              onTap: () {
                                Get.find<AnimalController>()
                                    .selectAnimal(animals[index]);
                                Get.toNamed("/animal_info");
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
