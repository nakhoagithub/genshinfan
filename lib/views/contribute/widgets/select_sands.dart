
import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/contribute_character_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:get/get.dart';

class SelectSandsEffect extends StatelessWidget {
  const SelectSandsEffect({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    ContributeCharacterController contributeCharacterController =
        Get.find<ContributeCharacterController>();
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem<String>(value: 'not', child: Text('not'.tr)),
      DropdownMenuItem<String>(value: 'hp', child: Text('hp'.tr)),
      DropdownMenuItem<String>(value: 'def', child: Text('def'.tr)),
      DropdownMenuItem<String>(value: 'attack', child: Text('attack'.tr)),
      DropdownMenuItem<String>(
          value: 'energy_recharge', child: Text('energy_recharge'.tr)),
      DropdownMenuItem<String>(
          value: 'elemental_mastery', child: Text('elemental_mastery'.tr)),
    ];
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("sands_effect".tr),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: double.infinity,
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: items,
                    value: contributeCharacterController.sandsEffect.value,
                    onChanged: (value) {
                      contributeCharacterController
                          .selectSandsEffect(value ?? "");
                    },
                    buttonDecoration: BoxDecoration(
                        border: Border.all(
                            color: ThemeApp.colorText(isDark: Get.isDarkMode)),
                        borderRadius: BorderRadius.circular(10)),
                    dropdownDecoration: BoxDecoration(
                        border: Border.all(
                            color: ThemeApp.colorText(isDark: Get.isDarkMode)),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}