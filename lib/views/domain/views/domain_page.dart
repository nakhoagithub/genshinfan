import 'package:flutter/material.dart';
import 'package:genshinfan/views/domain/controllers/domain_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/views/domain/widgets/item_domain.dart';
import 'package:genshinfan/views/layout_controller.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class DomainPage extends StatelessWidget {
  const DomainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("domain".tr),
      ),
      body: const _List(),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    DomainController domainController = Get.find<DomainController>();
    return Obx(() {
      List<Domain> domains = domainController.domains;
      return domains.isEmpty
          ? ListEmpty(title: "empty_domain".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount:
                  Get.find<LayoutController>().crossAxisCount3.value,
              childAspectRatio:
                  Get.find<LayoutController>().childAspectRatio3.value,
              children: List.generate(
                domains.length,
                (index) => ItemDomain(
                  domain: domains[index],
                  width: Get.find<LayoutController>().widthItem3.value,
                  onTap: () {
                    domainController.selectDomain(domains[index]);
                    Get.toNamed("/domain_info");
                  },
                ),
              ),
            );
    });
  }
}
