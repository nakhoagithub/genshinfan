import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/views/home/controllers/search_controller.dart';
import 'package:genshinfan/views/home/widgets/character_birthday_in_month.dart';
import 'package:genshinfan/views/home/widgets/character_up_today.dart';
import 'package:genshinfan/views/home/widgets/domain_today.dart';
import 'package:genshinfan/views/home/widgets/today.dart';
import 'package:genshinfan/views/home/widgets/weapon_up_today.dart';
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
    Get.put(SearchAppController());
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
            ListCharacterBirthdayInMonth(),
            HomeToday(),
            ListDomainToday(),
            // HomeTool(),
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
