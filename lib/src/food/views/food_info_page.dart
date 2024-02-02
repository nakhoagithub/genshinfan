import 'package:flutter/material.dart';
import 'package:genshinfan/src/food/controllers/food_controller.dart';
import 'package:genshinfan/src/food/widgets/food_info.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class FoodInfoPage extends StatelessWidget {
  const FoodInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    FoodController foodController = Get.find<FoodController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "food_information".tr,
          ),
        ),
        body: foodController.food.value == null
            ? PageEmpty(title: "select_food".tr)
            : const Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationFood(),
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
