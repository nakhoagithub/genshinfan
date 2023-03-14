import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/views/admin/admin_page.dart';
import 'package:genshinfan/views/admin/manage_user.dart';
import 'package:genshinfan/views/admin/manage_character_contribution.dart';
import 'package:genshinfan/views/artifact/artifact_info_page.dart';
import 'package:genshinfan/views/character/character_building_page.dart';
import 'package:genshinfan/views/character/character_info_page.dart';
import 'package:genshinfan/views/contribute/contribute_character_building_page.dart';
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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
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
            GetPage(
              name: '/admin',
              page: () => const AdminPage(),
              transition: Transition.native,
            ),
            GetPage(
              name: '/contribute_character_building',
              page: () => const ContributeCharacterBuildingPage(),
              transition: Transition.native,
            ),
            GetPage(
              name: '/character_building',
              page: () => const CharacterBuildingPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/manage_user_character_contribution',
              page: () => const ManageUserCharacterContribution(),
              transition: Transition.native,
            ),
            GetPage(
              name: '/manage_user',
              page: () => const ManageUser(),
              transition: Transition.native,
            ),
          ],
        );
      },
    );
  }
}
