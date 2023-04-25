import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/views/home/widgets/character_up_today.dart';
import 'package:genshinfan/views/home/widgets/weapon_up_today.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/text_css.dart';
import 'package:genshinfan/views/home/widgets/character_birthday_in_month.dart';
import 'package:genshinfan/views/home/widgets/domain_today.dart';
import 'package:get/get.dart';

class HomeToday extends StatelessWidget {
  const HomeToday({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    HomeController homeController = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          child: Row(
            children: [
              TextCSS(
                "<b>${"today".tr}</b>: <b><orange>${"day${homeController.today}".tr}</orange></b>",
                style: ThemeApp.textStyle(fontSize: 18),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: InkWell(
                  onTap: () {
                    dialogInfo("daily_reset_time".tr);
                  },
                  child: const Icon(
                    Icons.help_outline_rounded,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const ListDomainToday(),
        const ListCharacterBirthdayInMonth(),
        const ListCharacterUpToday(),
        const ListWeaponUpToday(),
      ],
    );
  }
}
