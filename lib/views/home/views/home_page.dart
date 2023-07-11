import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/widgets/character_birthday_in_month.dart';
import 'package:genshinfan/views/home/widgets/character_up_today.dart';
import 'package:genshinfan/views/home/widgets/domain_today.dart';
import 'package:genshinfan/views/home/widgets/today.dart';
import 'package:genshinfan/views/home/widgets/tool.dart';
import 'package:genshinfan/views/home/widgets/weapon_up_today.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            HomeTool(),
            ListCharacterBirthdayInMonth(),
            ListCharacterUpToday(),
            ListWeaponUpToday(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
