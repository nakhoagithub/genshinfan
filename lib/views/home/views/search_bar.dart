import 'package:flutter/material.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/home/controllers/search_controller.dart';
import 'package:genshinfan/views/home/widgets/search_artifact.dart';
import 'package:genshinfan/views/home/widgets/search_character.dart';
import 'package:genshinfan/views/home/widgets/search_weapon.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:get/get.dart';

class HomeSearch extends SearchDelegate {
  @override
  String? get searchFieldLabel => "search".tr;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const BackButtonApp(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    SearchAppController searchAppController = Get.find<SearchAppController>();
    String valueSearch = Tool.removeDiacritics(query.toLowerCase());
    List<Character> characters =
        searchAppController.searchCharacter(valueSearch);
    List<Weapon> weapons = searchAppController.searchWeapon(valueSearch);
    List<Artifact> artifacts = searchAppController.searchArtifact(valueSearch);
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   characters = ;
    //   weapons = ;
    // });
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListCharacter(characters: characters),
          ListWeapon(weapons: weapons),
          ListArtifact(artifacts: artifacts)
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
