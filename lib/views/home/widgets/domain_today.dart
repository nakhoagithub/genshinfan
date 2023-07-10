import 'package:flutter/material.dart';
import 'package:genshinfan/views/domain/controllers/domain_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/views/domain/widgets/item_domain.dart';
import 'package:get/get.dart';

class ListDomainToday extends StatelessWidget {
  const ListDomainToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    HomeController homeController = Get.find<HomeController>();
    List<Domain> domains =
        DomainService().getDomainToday("day${homeController.today}".tr) ?? [];
    return Container(
      margin: const EdgeInsets.all(4),
      height: (132 * 1.215) + 20,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: domains.length,
        itemBuilder: (context, index) {
          return ItemDomain(
            width: 110,
            domain: domains[index],
            onTap: () {
              Get.find<DomainController>().selectDomain(domains[index]);
              Get.toNamed('/domain_info');
            },
          );
        },
      ),
    );
  }
}
