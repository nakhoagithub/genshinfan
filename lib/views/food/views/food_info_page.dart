import 'package:flutter/material.dart';
import 'package:genshinfan/views/food/controllers/food_controller.dart';
import 'package:genshinfan/views/food/widgets/food_info.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/page_empty.dart';
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
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: foodController.scrollController,
                    child: const Column(
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
