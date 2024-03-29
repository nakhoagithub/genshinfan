import 'package:flutter/material.dart';
import 'package:genshinfan/src/domain/controllers/domain_controller.dart';
import 'package:genshinfan/src/home/controllers/home_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/src/domain/widgets/item_domain.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:get/get.dart';

class ListDomainToday extends StatelessWidget {
  const ListDomainToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    HomeController homeController = Get.find<HomeController>();
    return Obx(() {
      List<Domain> domains = homeController.domainToday;
      return Container(
        margin: const EdgeInsets.all(4),
        height: 160,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: domains.length,
          itemBuilder: (context, index) {
            return ItemDomain(
              domain: domains[index],
              width: Get.find<LayoutController>().widthItem3.value,
              onTap: () {
                Get.find<DomainController>().selectDomain(domains[index]);
                Get.toNamed('/domain_info');
              },
            );
          },
        ),
      );
    });
  }
}
