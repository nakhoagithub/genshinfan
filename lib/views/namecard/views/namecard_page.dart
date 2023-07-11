import 'package:flutter/material.dart';
import 'package:genshinfan/views/namecard/controllers/namecard_controller.dart';
import 'package:genshinfan/models/game/namecard.dart';
import 'package:genshinfan/views/namecard/widgets/item_namecard.dart';
import 'package:genshinfan/views/widgets/list_empty.dart';
import 'package:get/get.dart';

class NamecardPage extends StatelessWidget {
  const NamecardPage({super.key});

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
    NamecardController namecardController = Get.find<NamecardController>();
    return Obx(() {
      List<Namecard> namecards = namecardController.namecards;
      return namecards.isEmpty
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
                    Get.toNamed("/namecard_info");
                  },
                );
              },
            );
    });
  }
}
