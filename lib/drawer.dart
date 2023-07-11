import 'package:flutter/material.dart';
import 'package:genshinfan/views/setting/views/setting_page.dart';
import 'package:get/get.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: const MenuPage(),
    );
  }
}