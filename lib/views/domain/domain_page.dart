import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/domain/controllers/domain_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/domain.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/domain/widgets/item_domain.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class DomainPage extends StatelessWidget {
  const DomainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "domain".tr,
            width: double.infinity,
          ),
          const Expanded(
            child: _List(),
          )
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    DomainController domainController = Get.find<DomainController>();
    HomeController homeController = Get.find<HomeController>();
    double sizeItem = Config.sizeItem2;
    return Obx(() {
      List<Domain> domains = domainController.domains;
      return SizedBox(
        width: Config.widthCenter,
        child: domains.isEmpty
            ? ListEmpty(title: "empty_domain".tr)
            : GridView.count(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                childAspectRatio: sizeItem / (sizeItem * 1.215),
                children: List.generate(
                  domains.length,
                  (index) => FadeInUp(
                    child: Center(
                      child: SizedBox(
                        width: sizeItem,
                        height: sizeItem * 1.215,
                        child: ItemDomain(
                          domain: domains[index],
                          onTap: () {
                            domainController.selectDomain(domains[index]);
                            homeController.pageCenter();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
