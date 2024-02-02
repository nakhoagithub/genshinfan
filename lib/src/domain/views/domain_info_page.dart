import 'package:flutter/material.dart';
import 'package:genshinfan/src/domain/controllers/domain_controller.dart';

import 'package:genshinfan/src/domain/widgets/domain_info.dart';
import 'package:genshinfan/src/domain/widgets/domain_lv.dart';
import 'package:genshinfan/src/widgets/back_button.dart';
import 'package:genshinfan/src/widgets/page_empty.dart';
import 'package:get/get.dart';

class DomainInfoPage extends StatelessWidget {
  const DomainInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    DomainController domainController = Get.find<DomainController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "domain_information".tr,
          ),
        ),
        body: domainController.domain.value == null
            ? PageEmpty(title: "select_domain".tr)
            : const Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InformationDomain(),
                        InformationDomainLv(),
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
