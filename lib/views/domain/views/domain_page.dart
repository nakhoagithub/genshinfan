import 'package:flutter/material.dart';
import 'package:genshinfan/app_layout.dart';
import 'package:genshinfan/views/domain/controllers/domain_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/views/domain/widgets/item_domain.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class DomainPage extends StatelessWidget {
  const DomainPage({super.key});

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
    DomainController domainController = Get.find<DomainController>();
    return Obx(() {
      List<Domain> domains = domainController.domains;
      return domains.isEmpty
          ? ListEmpty(title: "empty_domain".tr)
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount:
                  Get.find<AppLayoutController>().crossAxisCountBig(),
              childAspectRatio:
                  Get.find<AppLayoutController>().childAspectRatioBig(),
              children: List.generate(
                domains.length,
                (index) => ItemDomain(
                  domain: domains[index],
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
