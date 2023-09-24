import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import '../../../models/game/animal.dart';

class AnimalController extends GetxController with GetTickerProviderStateMixin {
  List<Animal> animals = Get.find<MainController>().animals;
  Rx<Status> status = Status.init.obs;
  Rx<Animal?> animal = Rx(null);

  void selectAnimal(Animal value) async {
    animal.value = value;
  }
}
