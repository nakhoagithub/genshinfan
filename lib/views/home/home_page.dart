import 'package:flutter/material.dart';
import 'package:genshinfan/views/home/widgets/home_notification.dart';
import 'package:genshinfan/views/home/widgets/home_today.dart';
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // logo
            Center(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/logo_genshin_impact.png",
                  height: 80,
                ),
              ),
            ),
            // hôm nay
            const HomeToday(),
            const HomeNotification(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
