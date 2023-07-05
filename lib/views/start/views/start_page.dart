import 'package:flutter/material.dart';
import 'package:genshinfan/views/start/controllers/start_controller.dart';
import 'package:get/get.dart';

import '../../../utils/theme.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StartController());
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _WelcomeApp(),
              _VersionApp(),
              _LogoApp(),
              _Progress(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeApp extends StatelessWidget {
  const _WelcomeApp();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Center(
        child: Text(
          "welcome_to_app".tr,
          textAlign: TextAlign.center,
          style: ThemeApp.textStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _VersionApp extends StatelessWidget {
  const _VersionApp();

  @override
  Widget build(BuildContext context) {
    StartController startController = Get.find<StartController>();
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Center(
        child: Obx(
          () => Text(
            "version".trParams({"version": startController.version.value}),
            style: ThemeApp.textStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoApp extends StatelessWidget {
  const _LogoApp();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            "assets/icons/ic_launcher.png",
            height: w * 0.3,
            width: w * 0.3,
          ),
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress();

  @override
  Widget build(BuildContext context) {
    StartController startController = Get.find<StartController>();
    return Center(
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // progress
            SizedBox(
              width: 200,
              child: Obx(
                () => LinearProgressIndicator(
                  color: Colors.green,
                  value: (startController.received.value /
                      startController.total.value),
                ),
              ),
            ),
            // text
            Expanded(
              child: Center(
                child: Obx(
                  () => Text(
                    startController.log.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: startController.colorLog.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
