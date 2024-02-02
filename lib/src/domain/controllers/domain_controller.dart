import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:get/get.dart';

class DomainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Domain> domains = Get.find<MainController>().domains;
  Rx<Domain?> domain = Rx(null);

  void selectDomain(Domain domain) {
    this.domain.value = domain;
  }
}
