import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/controllers/manage_user_controller.dart';
import 'package:genshinfan/objects/app/user.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/widgets/wait.dart';
import 'package:get/get.dart';

class ManageUser extends StatelessWidget {
  const ManageUser({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManageUserController());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("manager".tr),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    ManageUserController manageUserController =
        Get.find<ManageUserController>();
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
                  child: _Item(
                    user: users[index],
                  ),
                );
              },
            );
    });
  }
}

class _Item extends StatelessWidget {
  final UserApp user;
  const _Item({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    int roleCurrentUser = Get.find<AppController>().userApp.value?.role ?? 10;
    return Card(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: user.linkImage ?? "",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const Center(
                        child: SizedBox(
                          height: 12,
                          width: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset("assets/images/ic_user.png");
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.name}",
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${user.email}",
                      style: ThemeApp.textStyle(
                        isDark: Get.isDarkMode,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // quyền
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "permission".tr,
                    style: ThemeApp.textStyle(isDark: Get.isDarkMode),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<dynamic>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      value: user.role,
                      items: Config.menuRole,
                      onChanged: !Config.roleAdminLV1.contains(roleCurrentUser)
                          ? null
                          : (value) async {
                              await Get.find<ManageUserController>()
                                  .changePermission(user.uid, value);
                            },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
