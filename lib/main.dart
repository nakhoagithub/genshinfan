import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/views/artifact/artifact_info_page.dart';
import 'package:genshinfan/views/character/character_info_page.dart';
import 'package:genshinfan/views/domain/domain_info_page.dart';
import 'package:genshinfan/views/enemy/enemy_info_page.dart';
import 'package:genshinfan/views/home.dart';
import 'package:genshinfan/views/resource/resouce_info_page.dart';
import 'package:genshinfan/views/start_page.dart';
import 'package:genshinfan/views/weapon/weapon_info_page.dart';
import 'package:get/get.dart';
import 'resources/utils/init.dart';
import 'resources/utils/localization.dart';
import 'resources/utils/theme.dart';
import 'views/setting/setting_page.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await init();

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  runApp(const App());
}

class App extends GetView<AppController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.put(AppController());
    return GetBuilder<AppController>(
      init: appController,
      initState: (_) {},
      builder: (_) {
        context.theme;
        return GetMaterialApp(
          // theme
          theme: appController.themeData.value,
          darkTheme: ThemeApp.dark(),
          themeMode: ThemeApp.themeMode,

          // locale
          locale: Localization.locale,
          fallbackLocale: Localization.fallbackLocale,
          translations: Localization(),
          enableLog: false,
          initialRoute: '/',
          getPages: [
            GetPage(
              name: '/',
              page: () => const StartPage(),
              // transition: Transition.fade,
            ),
            GetPage(
              name: '/home',
              page: () => const Home(),
              binding: AppBinding(),
            ),
            GetPage(
              name: '/character_info',
              page: () => const CharacterInfoPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/weapon_info',
              page: () => const WeaponInfoPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/resource_info',
              page: () => const ResourceInfoPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/artifact_info',
              page: () => const ArtifactInfoPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/domain_info',
              page: () => const DomainInfoPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/enemy_info',
              page: () => const EnemyInfoPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/setting',
              page: () => const SettingPage(),
              transition: Transition.native,
            ),
          ],
        );
      },
    );
  }
}
