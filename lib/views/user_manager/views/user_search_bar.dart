import 'package:flutter/material.dart';
import 'package:genshinfan/models/app/user.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:genshinfan/views/user_manager/controllers/user_controller.dart';
import 'package:genshinfan/views/user_manager/widgets/image_user.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:get/get.dart';

class UserSearchBar extends SearchDelegate {
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
    List<UserApp> users = Get.find<UserController>().users;
    List<UserApp> searchs = users.where((element) {
      final result = Tool.removeDiacritics(element.name?.toLowerCase() ?? "");
      final resultEmail =
          Tool.removeDiacritics(element.email?.toLowerCase() ?? "");
      final input = Tool.removeDiacritics(query.toLowerCase());

      return result.contains(input) || resultEmail.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: searchs.length,
      itemBuilder: (context, index) {
        return _ItemUserSearch(user: searchs[index]);
      },
    );
  }
}

class _ItemUserSearch extends StatelessWidget {
  final UserApp user;
  const _ItemUserSearch({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageUser(linkImage: user.linkImage),
      title: Text(user.name ?? ""),
      subtitle: Text(user.email ?? ""),
      onTap: () {
        Get.find<UserController>().selectUser(user);
        Get.toNamed("/user_manager_page");
      },
    );
  }
}
