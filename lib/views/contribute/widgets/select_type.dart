import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:get/get.dart';

class SelectTypeSet extends StatelessWidget {
  const SelectTypeSet({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    List<String> chips = ['set2_artifact'.tr, 'set4_artifact'.tr];
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 50,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: chips.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(4),
              child: Obx(
                () => ChoiceChip(
                  label: Text(chips[index]),
                  selected: contributeCharacterController.type.value == index,
                  onSelected: (bool isSelected) {
                    contributeCharacterController.selectTypeSet(index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
