import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/namecard/controllers/namecard_controller.dart';
import 'package:genshinfan/models/namecard.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/views/namecard/widgets/item_namecard.dart';
import 'package:genshinfan/views/widgets/app_bar.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class NamecardPage extends StatelessWidget {
  const NamecardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: [
          AppBarCenter(
            title: "namecard".tr,
            width: double.infinity,
          ),
          const Expanded(child: _List()),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    NamecardController namecardController = Get.find<NamecardController>();
    HomeController homeController = Get.find<HomeController>();
    return Obx(() {
      List<Namecard> namecards = namecardController.namecards;
      return SizedBox(
        width: Config.widthCenter,
        child: namecards.isEmpty
            ? ListEmpty(title: "empty_namecard".tr)
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: namecards.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemNamecard(
                    namecard: namecards[index],
                    onTap: () {
                      namecardController.selectNamecard(namecards[index]);
                      homeController.pageCenter();
                    },
                  );
                },
              ),
      );
    });
  }
}
