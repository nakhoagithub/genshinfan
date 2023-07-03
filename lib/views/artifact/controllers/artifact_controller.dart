import 'package:flutter/material.dart';
import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:get/get.dart';

class ArtifactController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Artifact> artifacts = Get.find<AppController>().artifacts;
  Rx<Artifact?> artifact = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectArtifact(Artifact artifact) {
    this.artifact.value = artifact;
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
