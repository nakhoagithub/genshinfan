import 'package:flutter/material.dart';
import 'package:genshinfan/utils/role.dart';
import 'package:genshinfan/views/widgets/item_menu.dart';
import 'package:genshinfan/views/widgets/title_of_menu.dart';
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("admin".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // quản lý data
            !Role.viewDataManagement()
                ? const SizedBox()
                : TitleApp(title: "data_management".tr),
            !Role.viewDataManagement()
                ? const SizedBox()
                : ItemMenu(
                    icon: const Icon(Icons.list_alt_rounded),
                    title: "contribution_character".tr,
                    description: "manage_user_character_contribution".tr,
                    onTap: () {
                      Get.toNamed("/manage_user_character_contribution");
                    },
                  ),

            // quản lý người dùng
            !Role.viewUserManagement()
                ? const SizedBox()
                : TitleApp(title: "user_management".tr),
            // danh sách người dùng - quản lý quyền
            !Role.viewUserManagement()
                ? const SizedBox()
                : ItemMenu(
                    icon: const Icon(Icons.manage_accounts_rounded),
                    title: "role_and_data_user".tr,
                    onTap: () {
                      Get.toNamed("/user_page");
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
