import 'package:flutter/material.dart';
import 'package:genshinfan/views/user_manager/controllers/update_user_controller.dart';
import 'package:genshinfan/views/user_manager/views/widgets/edit_role.dart';
import 'package:get/get.dart';

class UserManagerPage extends StatelessWidget {
  const UserManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateUserController updateUserController = Get.put(UpdateUserController());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("user_management".tr),
        actions: [
          IconButton(
            onPressed: () {
              updateUserController.updateUser();
            },
            icon: const Icon(Icons.save_alt_rounded),
          )
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
    return const Column(
      children: [
        EditRoleUserUserManager(),
      ],
    );
  }
}
