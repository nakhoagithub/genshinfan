import 'package:flutter/material.dart';
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
      child: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // hôm nay
            HomeToday(),
            // HomeNotification(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
