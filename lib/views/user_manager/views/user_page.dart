import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/utils/role.dart';
import 'package:genshinfan/views/user_manager/controllers/user_controller.dart';
import 'package:genshinfan/models/app/user.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/user_manager/views/user_search_bar.dart';
import 'package:genshinfan/views/user_manager/views/widgets/image_user.dart';
import 'package:genshinfan/views/widgets/back_button.dart';
import 'package:genshinfan/views/widgets/wait.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("user".tr),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: UserSearchBar());
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    UserController manageUserController = Get.find<UserController>();
    return Obx(() {
      int status = manageUserController.status.value;
      List<UserApp> users = manageUserController.users;
      return status == 1
          ? const WaitAMinute()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return FadeInUp(
                  child: _ItemUser(
                    user: users[index],
                  ),
                );
              },
            );
    });
  }
}

class _ItemUser extends StatelessWidget {
  final UserApp user;
  const _ItemUser({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Get.find<UserController>().selectUser(user);
          Get.toNamed("/user_manager_page");
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  ImageUser(linkImage: user.linkImage),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.name}",
                        style: ThemeApp.textStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Role.colorForRole(user.roles),
                        ),
                      ),
                      Text(
                        "${user.email}",
                        style: ThemeApp.textStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              // quyền
              // Container(
              //   margin: const EdgeInsets.only(top: 10),
              //   child: Row(
              //     children: [
              //       Text(
              //         "permission".tr,
              //         style: ThemeApp.textStyle(),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: DropdownButtonFormField<dynamic>(
              //           decoration: const InputDecoration(
              //             border: OutlineInputBorder(),
              //             contentPadding: EdgeInsets.only(left: 10),
              //           ),
              //           value: user.role,
              //           items: Config.menuRole,
              //           onChanged: !Config.roleAdminLV1.contains(roleCurrentUser)
              //               ? null
              //               : (value) async {
              //                   await Get.find<ManageUserController>()
              //                       .changePermission(user.uid, value);
              //                 },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
