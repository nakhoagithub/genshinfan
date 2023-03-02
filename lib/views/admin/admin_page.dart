import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:genshinfan/views/widgets/item_menu.dart';
import 'package:genshinfan/views/widgets/title_of_menu.dart';
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("admin".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // quản lý data
            TitleApp(title: "data_management".tr),
            ItemMenu(
              icon: const Icon(Icons.list_alt_rounded),
              title: "contribution_character".tr,
              description: "manage_user_character_contribution".tr,
              onTap: () {
                Get.toNamed("/manage_user_character_contribution");
              },
            ),

            // quản lý người dùng
            TitleApp(title: "user_management".tr),
            // danh sách người dùng - quản lý quyền
            ItemMenu(
              icon: const Icon(Icons.manage_accounts_rounded),
              title: "role_and_data_user".tr,
              onTap: () {
                Get.toNamed("/manage_user");
              },
            ),
          ],
        ),
      ),
    );
  }
}
