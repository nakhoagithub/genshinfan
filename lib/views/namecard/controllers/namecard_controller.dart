import 'package:flutter/material.dart';
import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/models/namecard.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NamecardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Namecard> namecards = <Namecard>[].obs;
  Rx<Namecard?> namecard = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectNamecard(Namecard namecard) {
    this.namecard.value = namecard;
    update();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    super.update(ids, condition);
  }

  @override
  void onInit() {
    namecards.addAll(Get.find<AppController>().namecards);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
