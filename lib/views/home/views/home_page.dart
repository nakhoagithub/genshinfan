import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/home/views/widgets/character_birthday_in_month.dart';
import 'package:genshinfan/views/home/views/widgets/character_up_today.dart';
import 'package:genshinfan/views/home/views/widgets/domain_today.dart';
import 'package:genshinfan/views/home/views/widgets/today.dart';
import 'package:genshinfan/views/home/views/widgets/weapon_up_today.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    Get.put(HomeController());
    context.theme;
    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      height: double.infinity,
      child: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeToday(),
            ListDomainToday(),
            // HomeTool(),
            ListCharacterBirthdayInMonth(),
            ListCharacterUpToday(),
            ListWeaponUpToday(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
