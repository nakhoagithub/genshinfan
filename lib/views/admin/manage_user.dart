import 'package:flutter/material.dart';
import 'package:genshinfan/views/widgets/backbutton.dart';
import 'package:get/get.dart';

class ManageUser extends StatelessWidget {
  const ManageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonApp(),
        title: Text("manager".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // quản lý data
            
          ],
        ),
      ),
    );
  }
}
