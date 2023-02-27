import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/domain/widgets/domain_info.dart';
import 'package:genshinfan/views/domain/widgets/domain_lv.dart';
import 'package:get/get.dart';

class DomainInfoPage extends StatelessWidget {
  const DomainInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    DomainController domainController = Get.find<DomainController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: ThemeApp.colorCard(isDark: Get.isDarkMode),
        appBar: AppBar(
          leading: const BackButtonApp(),
          centerTitle: true,
          title: Text(
            "domain_information".tr,
          ),
        ),
        body: domainController.domain.value == null
            ? Center(
                child: Text("choose_domain".tr),
              )
            : Stack(
                children: [
                  // content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: domainController.scrollController,
                    child: const Column(
                      children: [
                        InformationDomain(),
                        InformationDomainLv(),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
