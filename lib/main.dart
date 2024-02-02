import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/init.dart';
import 'package:genshinfan/utils/localization.dart';
import 'package:genshinfan/utils/theme.dart';
import 'package:genshinfan/src/achievement/views/achievement_info_page.dart';
import 'package:genshinfan/src/achievement/views/achievement_page.dart';
import 'package:genshinfan/src/admin/views/admin_page.dart';
import 'package:genshinfan/src/animal/views/animal_info_page.dart';
import 'package:genshinfan/src/animal/views/animal_page.dart';
import 'package:genshinfan/src/artifact/views/artifact_page.dart';
import 'package:genshinfan/src/craft/views/craft_info_page.dart';
import 'package:genshinfan/src/craft/views/craft_page.dart';
import 'package:genshinfan/src/domain/views/domain_page.dart';
import 'package:genshinfan/src/enemy/views/enemy_page.dart';
import 'package:genshinfan/src/food/views/food_info_page.dart';
import 'package:genshinfan/src/food/views/food_page.dart';
import 'package:genshinfan/src/geography/views/geography_info_page.dart';
import 'package:genshinfan/src/geography/views/geography_page.dart';
import 'package:genshinfan/src/layout_controller.dart';
import 'package:genshinfan/src/namecard/views/namecard_info_page.dart';
import 'package:genshinfan/src/namecard/views/namecard_page.dart';
import 'package:genshinfan/src/outfit/views/outfit_infor_page.dart';
import 'package:genshinfan/src/outfit/views/outfit_page.dart';
import 'package:genshinfan/src/user_manager/views/user_manager_page.dart';
import 'package:genshinfan/src/user_manager/views/user_page.dart';
import 'package:genshinfan/src/admin/views/manage_character_contribution.dart';
import 'package:genshinfan/src/artifact/views/artifact_info_page.dart';
import 'package:genshinfan/src/character/views/character_building_page.dart';
import 'package:genshinfan/src/character/views/character_info_page.dart';
import 'package:genshinfan/src/contribute/views/contribute_character_building_page.dart';
import 'package:genshinfan/src/domain/views/domain_info_page.dart';
import 'package:genshinfan/src/enemy/views/enemy_info_page.dart';
import 'package:genshinfan/src/layout.dart';
import 'package:genshinfan/src/resource/views/resouce_info_page.dart';
import 'package:genshinfan/src/start/views/start_page.dart';
import 'package:genshinfan/src/weapon/views/weapon_info_page.dart';
import 'package:genshinfan/src/windglider/views/windglider_info_page.dart';
import 'package:genshinfan/src/windglider/views/windglider_page.dart';
import 'package:get/get.dart';

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

class App extends GetView<MainController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    MainController appController = Get.put(MainController());
    LayoutController layoutController = Get.put(LayoutController());
    return OrientationBuilder(builder: (p0, p1) {
      layoutController.getWithItem();
      return GetBuilder<MainController>(
        init: appController,
        initState: (_) {},
        builder: (_) {
          layoutController.menu.value = 0;
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
                page: () => const Layout(),
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
                name: '/artifact_page',
                page: () => const ArtifactPage(),
              ),
              GetPage(
                name: '/artifact_info',
                page: () => const ArtifactInfoPage(),
              ),
              GetPage(
                name: '/domain_page',
                page: () => const DomainPage(),
              ),
              GetPage(
                name: '/domain_info',
                page: () => const DomainInfoPage(),
              ),
              GetPage(
                name: '/food_page',
                page: () => const FoodPage(),
              ),
              GetPage(
                name: '/food_info',
                page: () => const FoodInfoPage(),
              ),
              GetPage(
                name: '/enemy_page',
                page: () => const EnemyPage(),
              ),
              GetPage(
                name: '/enemy_info',
                page: () => const EnemyInfoPage(),
              ),
              GetPage(
                name: '/animal_page',
                page: () => const AnimalPage(),
              ),
              GetPage(
                name: '/animal_info',
                page: () => const AnimalInfoPage(),
              ),
              GetPage(
                name: '/achievement_page',
                page: () => const AchievementPage(),
              ),
              GetPage(
                name: '/achievement_info',
                page: () => const AchievementInfoPage(),
              ),
              GetPage(
                name: '/namecard_page',
                page: () => const NamecardPage(),
              ),
              GetPage(
                name: '/namecard_info',
                page: () => const NamecardInfoPage(),
              ),
              GetPage(
                name: '/craft_page',
                page: () => const CraftPage(),
              ),
              GetPage(
                name: '/craft_info',
                page: () => const CraftInfoPage(),
              ),
              GetPage(
                name: '/outfit_page',
                page: () => const OutfitPage(),
              ),
              GetPage(
                name: '/outfit_info',
                page: () => const OutfitInfoPage(),
              ),
              GetPage(
                name: '/geography_page',
                page: () => const GeographyPage(),
              ),
              GetPage(
                name: '/geography_info',
                page: () => const GeographyInfoPage(),
              ),
              GetPage(
                name: '/windglider_page',
                page: () => const WindgliderPage(),
              ),
              GetPage(
                name: '/windglider_info',
                page: () => const WindgliderInfoPage(),
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
    });
  }
}
