import 'package:flutter/material.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:get/get.dart';

class HomeSearchBar extends SearchDelegate {
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
        icon: const BackButtonApp());
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<UserApp> users = Get.find<UserController>().users;
    // List<UserApp> searchs = users.where((element) {
    //   final result = Tool.removeDiacritics(element.name?.toLowerCase() ?? "");
    //   final resultEmail =
    //       Tool.removeDiacritics(element.email?.toLowerCase() ?? "");
    //   final input = Tool.removeDiacritics(query.toLowerCase());

    //   return result.contains(input) || resultEmail.contains(input);
    // }).toList();

    // return ListView.builder(
    //   itemCount: searchs.length,
    //   itemBuilder: (context, index) {
    //     return _ItemUserSearch(user: searchs[index]);
    //   },
    // );

    return SizedBox();
  }
}
