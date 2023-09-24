import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:get/get.dart';

class ArtifactController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Artifact> artifacts = Get.find<MainController>().artifacts;
  Rx<Artifact?> artifact = Rx(null);

  void selectArtifact(Artifact artifact) {
    this.artifact.value = artifact;
  }
}
