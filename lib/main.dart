import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:genshinfan/views/app_controller.dart';
import 'package:genshinfan/views/achievement/views/achievement_info_page.dart';
import 'package:genshinfan/views/admin/views/admin_page.dart';
import 'package:genshinfan/views/animal/views/animal_info_page.dart';
import 'package:genshinfan/views/character/views/character_building_page_old.dart';
import 'package:genshinfan/views/craft/views/craft_info_page.dart';
import 'package:genshinfan/views/food/views/food_info_page.dart';
import 'package:genshinfan/views/geography/views/geography_info_page.dart';
import 'package:genshinfan/views/namecard/views/namecard_info_page.dart';
import 'package:genshinfan/views/outfit/views/outfit_infor_page.dart';
import 'package:genshinfan/views/user_manager/views/user_manager_page.dart';
import 'package:genshinfan/views/user_manager/views/user_page.dart';
import 'package:genshinfan/views/admin/views/manage_character_contribution.dart';
import 'package:genshinfan/views/artifact/views/artifact_info_page.dart';
import 'package:genshinfan/views/character/views/character_building_page.dart';
import 'package:genshinfan/views/character/views/character_info_page.dart';
import 'package:genshinfan/views/contribute/views/contribute_character_building_page.dart';
import 'package:genshinfan/views/domain/views/domain_info_page.dart';
import 'package:genshinfan/views/enemy/views/enemy_info_page.dart';
import 'package:genshinfan/views/home.dart';
import 'package:genshinfan/views/resource/views/resouce_info_page.dart';
import 'package:genshinfan/views/start/views/start_page.dart';
import 'package:genshinfan/views/weapon/views/weapon_info_page.dart';
import 'package:genshinfan/views/windglider/views/windglider_info_page.dart';
import 'package:get/get.dart';
import 'utils/init.dart';
import 'utils/localization.dart';
import 'utils/theme.dart';
import 'views/setting/views/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
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
            ),
            GetPage(
              name: '/weapon_info',
              page: () => const WeaponInfoPage(),
            ),
            GetPage(
              name: '/resource_info',
              page: () => const ResourceInfoPage(),
            ),
            GetPage(
              name: '/artifact_info',
              page: () => const ArtifactInfoPage(),
            ),
            GetPage(
              name: '/domain_info',
              page: () => const DomainInfoPage(),
            ),
            GetPage(
              name: '/food_info',
              page: () => const FoodInfoPage(),
            ),
            GetPage(
              name: '/enemy_info',
              page: () => const EnemyInfoPage(),
            ),
            GetPage(
              name: '/animal_info',
              page: () => const AnimalInfoPage(),
            ),
            GetPage(
              name: '/achievement_info',
              page: () => const AchievementInfoPage(),
            ),
            GetPage(
              name: '/namecard_info',
              page: () => const NamecardInfoPage(),
            ),
            GetPage(
              name: '/craft_info',
              page: () => const CraftInfoPage(),
            ),
            GetPage(
              name: '/outfit_info',
              page: () => const OutfitInfoPage(),
            ),
            GetPage(
              name: '/geography_info',
              page: () => const GeographyInfoPage(),
            ),
            GetPage(
              name: '/windglider_info',
              page: () => const WindgliderInfoPage(),
            ),
            GetPage(
              name: '/setting',
              page: () => const MenuPage(),
              transition: Transition.leftToRight,
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
              name: '/character_building_old',
              page: () => const CharacterBuildingOldPage(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/manage_user_character_contribution',
              page: () => const ManageUserCharacterContribution(),
              transition: Transition.native,
            ),
            GetPage(
              name: '/user_page',
              page: () => const UserPage(),
              transition: Transition.native,
            ),
            GetPage(
              name: '/user_manager_page',
              page: () => const UserManagerPage(),
              transition: Transition.native,
            ),
          ],
        );
      },
    );
  }
}
