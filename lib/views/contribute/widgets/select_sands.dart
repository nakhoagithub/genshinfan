import 'package:animate_do/animate_do.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/contribute/controllers/contribute_character_controller.dart';

import 'package:get/get.dart';

class SelectSandsEffect extends StatelessWidget {
  const SelectSandsEffect({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    List<String> items = [
      "option",
      "hp",
      "def",
      "attack",
      "energy_recharge",
      "elemental_mastery",
    ];
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: double.infinity,
              child: DropdownSearch<String>.multiSelection(
                items: [...items.map((e) => e)],
                itemAsString: (item) => item,
                dropdownBuilder: (context, selectedItems) {
                  return Wrap(
                    children: [
                      ...selectedItems.map(
                        (e) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Chip(label: Text(e.tr)),
                        ),
                      )
                    ],
                  );
                },
                popupProps: PopupPropsMultiSelection.dialog(
                  dialogProps: const DialogProps(
                      clipBehavior: Clip.antiAliasWithSaveLayer),
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(title: Text(item.tr));
                  },
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "sands_effect".tr,
                    border: const OutlineInputBorder(),
                  ),
                  baseStyle: ThemeApp.textStyle(),
                ),
                onChanged: (values) {
                  contributeCharacterController.selectSandsEffect(values);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
