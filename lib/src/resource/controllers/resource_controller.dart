import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResourceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Resource> resources = <Resource>[].obs;
  List<Resource> resourcesView = <Resource>[].obs;
  Rx<Resource?> resource = Rx(null);

  void selectResource(Resource resource) {
    this.resource.value = resource;
  }

  @override
  void onInit() {
    resources.addAll(Get.find<MainController>().resources);
    resourcesView.addAll(Get.find<MainController>().resources);
    super.onInit();
  }
}
