import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/models/app/role_app.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/views/user_manager/controllers/update_user_controller.dart';
import 'package:get/get.dart';

class EditRoleUserUserManager extends StatelessWidget {
  const EditRoleUserUserManager({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateUserController updateUserController =
        Get.find<UpdateUserController>();
    List<RoleApp> roles = updateUserController.roles;
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: DropdownSearch<RoleApp>.multiSelection(
        selectedItems: roles,
        items: [...Config.menuRole.map((e) => e)],
        itemAsString: (item) => item.name,
        dropdownBuilder: (context, selectedItems) {
          return Wrap(
            children: [
              ...selectedItems.map(
                (e) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(label: Text(e.name)),
                ),
              )
            ],
          );
        },
        popupProps: PopupPropsMultiSelection.dialog(
          dialogProps:
              const DialogProps(clipBehavior: Clip.antiAliasWithSaveLayer),
          itemBuilder: (context, item, isSelected) {
            return ListTile(title: Text(item.name));
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "role".tr,
            border: const OutlineInputBorder(),
          ),
          baseStyle: ThemeApp.textStyle(),
        ),
        onChanged: (values) {
          updateUserController.roles.value = values;
        },
      ),
    );
  }
}
