import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonApp extends StatelessWidget {
  const BackButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.keyboard_arrow_left_rounded),
      ),
    );
  }
}
