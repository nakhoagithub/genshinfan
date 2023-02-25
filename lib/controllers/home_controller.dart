import 'dart:async';
import 'dart:developer';

import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/models/traffic.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/talent.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/widgets/slide_layout.dart';

class HomeController extends GetxController {
  StreamController<ScreenPosition> homeStream = StreamController();
  Rx<Traffic?> traffic = Rx(null);
  RxInt today = 0.obs;
  RxInt day = 0.obs;
  RxInt month = 0.obs;
  RxBool hasBirthday = false.obs;

  RxList<Domain> domainToday = <Domain>[].obs;

  void pageLeft() {
    homeStream.sink.add(ScreenPosition.left);
  }

  void pageCenter() {
    homeStream.sink.add(ScreenPosition.center);
  }

  void pageRight() {
    homeStream.sink.add(ScreenPosition.right);
  }

  List<Domain>? getDomainToday(String today) {
    AppController appController = Get.find<AppController>();
    List<Domain> domains = appController.domains;
    List<Domain> domainToday = domains.where((element) {
      List<String>? daysofweeks = element.daysofweek?.where((element) {
        return element == today;
      }).toList();
      return daysofweeks != null && daysofweeks.isNotEmpty;
    }).toList();
    this.domainToday.value = domainToday;
    return domainToday;
  }

  List<Character>? getCharacterBirthdayInMonth() {
    AppController appController = Get.find<AppController>();
    List<Character> characters = appController.characters;
    List<Character> characterBirthday = characters.where((element) {
      if (element.birthdaymmdd != "") {
        String mm = element.birthdaymmdd
            .substring(0, element.birthdaymmdd.indexOf("/"));
        if (int.parse(mm) == month.value) {
          return true;
        }
      }
      return false;
    }).toList();

    characterBirthday.sort(
      (a, b) {
        String aDay = a.birthdaymmdd.substring(a.birthdaymmdd.indexOf("/"));
        String bDay = b.birthdaymmdd.substring(b.birthdaymmdd.indexOf("/"));
        return aDay.compareTo(bDay);
      },
    );
    return characterBirthday;
  }

  List<Character>? getCharacterBirthdayToday() {
    AppController appController = Get.find<AppController>();
    List<Character> characters = appController.characters;
    List<Character> characterBirthday = characters.where((element) {
      if (element.birthdaymmdd != "") {
        String mm = element.birthdaymmdd
            .substring(0, element.birthdaymmdd.indexOf("/"));
        String dd = element.birthdaymmdd
            .substring(element.birthdaymmdd.indexOf("/") + 1);
        if (int.parse(mm) == month.value && int.parse(dd) == day.value) {
          return true;
        }
      }
      return false;
    }).toList();

    characterBirthday.sort(
      (a, b) {
        String aDay = a.birthdaymmdd.substring(a.birthdaymmdd.indexOf("/"));
        String bDay = b.birthdaymmdd.substring(b.birthdaymmdd.indexOf("/"));
        return aDay.compareTo(bDay);
      },
    );
    return characterBirthday;
  }

  List<Character>? getCharacterUpToday() {
    AppController appController = Get.find<AppController>();
    List<Character> characters = appController.characters;
    List<Domain> domains = domainToday;
    List<String> nameResourceToday = [];
    for (var domain in domains) {
      if (domain.domainLvs != null) {
        for (var lv in domain.domainLvs!) {
          for (var rw in lv.rewardpreview) {
            Resource? resource = Tools.getResourceFromName(rw.name);
            if (resource != null && resource.category == "AVATAR_MATERIAL") {
              nameResourceToday.add(rw.name);
            }
          }
        }
      }
    }

    List<Character> characterUpToday = characters.where((element) {
      if (element.association == "MAINACTOR") {
        // nhà lữ hành
        
      } else {
        if (element.talent != null) {
          for (var key in element.talent!.costs.keys) {
            List<Cost>? cost = element.talent!.costs[key];
            if (cost != null) {
              for (var e in cost) {
                if (nameResourceToday.contains(e.name)) {
                  return true;
                }
              }
            }
          }
        }
      }
      return false;
    }).toList();
    characterUpToday.sort(
      (a, b) {
        return b.rarity.compareTo(a.rarity);
      },
    );
    return characterUpToday;
  }

  List<Weapon>? getWeaponUpToday() {
    AppController appController = Get.find<AppController>();
    List<Weapon> weapons = appController.weapons;
    List<Domain> domains = domainToday;
    List<String> nameResourceToday = [];
    for (var domain in domains) {
      if (domain.domainLvs != null) {
        for (var lv in domain.domainLvs!) {
          for (var rw in lv.rewardpreview) {
            Resource? resource = Tools.getResourceFromName(rw.name);
            if (resource != null && resource.category == "AVATAR_MATERIAL") {
              nameResourceToday.add(rw.name);
            }
          }
        }
      }
    }
    List<Weapon> weaponUpToday = weapons.where((element) {
      if (element.costs != null) {
        List<AscendWeapon> ascendAll = [];
        ascendAll.addAll(element.costs!.ascend1);
        ascendAll.addAll(element.costs!.ascend2);
        ascendAll.addAll(element.costs!.ascend3);
        ascendAll.addAll(element.costs!.ascend4);
        ascendAll.addAll(element.costs!.ascend5 ?? []);
        ascendAll.addAll(element.costs!.ascend6 ?? []);

        for (var ascend in ascendAll) {
          if (nameResourceToday.contains(ascend.name)) {
            return true;
          }
        }
      }
      return false;
    }).toList();
    weaponUpToday.sort(
      (a, b) {
        return b.rarity.compareTo(a.rarity);
      },
    );
    return weaponUpToday;
  }

  void openGenshinMap() async {
    if (await canLaunchUrl(Uri.parse(Config.urlGenshinMap))) {
      await launchUrl(Uri.parse(Config.urlGenshinMap),
          mode: LaunchMode.externalApplication);
    } else {
      log("Không thể mở liên kết ${Config.urlGenshinMap}", name: "Open URL");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    DateTime dateTime = DateTime.now();
    today.value = dateTime.weekday;
    day.value = dateTime.day;
    month.value = dateTime.month;

    traffic.value = await AppService().getTraffic();
  }

  @override
  void dispose() {
    homeStream.close();
    super.dispose();
  }
}
