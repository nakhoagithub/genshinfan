import 'package:genshinfan/objects/items.dart';
import 'package:get/get.dart';

class StatWeapon {
  int level;
  bool bonus;
  int ascension;
  StatWeapon(this.level, this.bonus, this.ascension);
}

List<int> levels = [
  1, //0
  20, //0
  -20, //1
  40, //1
  -40, //2
  50, //2
  -50, //3
  60,
  -60,
  70,
  -70,
  80,
  -80,
  90
];

class Weapon {
  Weapon({
    this.key,
    required this.id,
    required this.name,
    this.dupealias,
    required this.description,
    required this.descriptionRaw,
    required this.weaponType,
    required this.weaponText,
    required this.rarity,
    required this.story,
    required this.baseAtkValue,
    required this.mainStatType,
    required this.mainStatText,
    required this.baseStatText,
    this.effectName,
    this.effectTemplateRaw,
    this.r1,
    this.r2,
    this.r3,
    this.r4,
    this.r5,
    required this.costs,
    this.images,
    this.stats,
    this.specialized,
    this.version,
  });

  String? key;
  final int id;
  final String name;
  final String? dupealias;
  final String description;
  final String descriptionRaw;
  final String weaponType;
  final String weaponText;
  final int rarity;
  final String story;
  final double baseAtkValue;
  final String? mainStatType;
  final String? mainStatText;
  final String? baseStatText;
  final String? effectName;
  final String? effectTemplateRaw;
  final WeaponRefine? r1;
  final WeaponRefine? r2;
  final WeaponRefine? r3;
  final WeaponRefine? r4;
  final WeaponRefine? r5;
  final Costs? costs;
  ImageWeapon? images;
  List<Stat>? stats;
  String? specialized;
  String? version;

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        key: json['key'],
        id: json['id'],
        name: json["name"],
        description: json["description"],
        descriptionRaw: json['descriptionRaw'],
        weaponType: json["weaponType"],
        weaponText: json["weaponText"],
        rarity: json["rarity"],
        story: json['story'],
        baseAtkValue: json["baseAtkValue"],
        mainStatType: json["mainStatType"],
        mainStatText: json["mainStatText"],
        baseStatText: json["baseStatText"],
        effectName: json["effectName"],
        effectTemplateRaw: json["effectTemplateRaw"],
        r1: json['r1'] == null ? null : WeaponRefine.fromJson(json['r1']),
        r2: json['r2'] == null ? null : WeaponRefine.fromJson(json['r2']),
        r3: json['r3'] == null ? null : WeaponRefine.fromJson(json['r3']),
        r4: json['r4'] == null ? null : WeaponRefine.fromJson(json['r4']),
        r5: json['r5'] == null ? null : WeaponRefine.fromJson(json['r5']),
        costs: json["costs"] == null ? null : Costs.fromJson(json["costs"]),
        images: json["images"] == null
            ? null
            : ImageWeapon.fromJson(json["images"]),
        stats: json["stats"] == null
            ? null
            : List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        specialized: json['specialized'],
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "id": id,
        "name": name,
        "description": description,
        "descriptionRaw": descriptionRaw,
        "weaponType": weaponType,
        "weaponText": weaponText,
        "rarity": rarity,
        "story": story,
        "baseAtkValue": baseAtkValue,
        "mainStatType": mainStatType,
        "mainStatText": mainStatText,
        "baseStatText": baseStatText,
        "effectName": effectName,
        "effectTemplateRaw": effectTemplateRaw,
        "r1": r1?.toJson(),
        "r2": r2?.toJson(),
        "r3": r3?.toJson(),
        "r4": r4?.toJson(),
        "r5": r5?.toJson(),
        "costs": costs?.toJson(),
        "images": images?.toJson(),
        "stats": stats == null
            ? null
            : List<dynamic>.from(stats!.map((x) => x.toJson())),
        "specialized": specialized,
        "version": version,
      };

  void setImage(dynamic json) {
    images = ImageWeapon.fromJson(json);
  }

  /// `stat`: base của vũ khí
  /// `curve`: base của tất vũ khí
  void setStat(dynamic stat, dynamic curve) {
    List<Stat> listData = [];
    List<dynamic> promotions = stat['promotion'];
    Map<String, dynamic> base = stat['base'];
    Map<String, dynamic> curveBase = stat['curve'];
    int ascension = 0;
    int maxLevel = promotions[promotions.length - 1]['maxlevel'];
    for (int i = 0; i < levels.length; i++) {
      // lấy level
      int level = levels[i] > 0 ? levels[i] : -levels[i];
      // lấy promotion với level
      dynamic promotion = promotions
          .firstWhereOrNull((element) => element['maxlevel'] == level);
      // xử lý ascension
      if (levels[i] < 0) {
        ascension += 1;
      }
      // xử lý attack
      double promotionAttack =
          promotion != null ? promotion['attack'].toDouble() : 0.0;
      double attack = base['attack'] * curve["$level"][curveBase['attack']] +
          promotionAttack;
      // xử lý specialized
      double specialized = base['specialized'] *
          curve["$level"][curveBase['specialized']].toDouble();
      // tạo stat
      Stat stat = Stat(
        level: level,
        ascension: ascension,
        bonus: levels[i] > 0 ? false : true,
        attack: attack,
        specialized: specialized,
      );
      listData.add(stat);

      // max lv thì không lặp nữa
      if (maxLevel == levels[i]) {
        break;
      }
    }
    stats = listData;
    specialized = stat['specialized'];
  }
}

class WeaponRefine {
  final String description;
  final List<String> values;
  const WeaponRefine({
    required this.description,
    required this.values,
  });

  factory WeaponRefine.fromJson(Map<String, dynamic> json) => WeaponRefine(
        description: json["description"],
        values: List<String>.from(json["values"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "values": List<dynamic>.from(values.map((x) => x)),
      };
}

class Costs {
  Costs({
    required this.ascend1,
    required this.ascend2,
    required this.ascend3,
    required this.ascend4,
    this.ascend5,
    this.ascend6,
  });

  List<Items> ascend1;
  List<Items> ascend2;
  List<Items> ascend3;
  List<Items> ascend4;
  List<Items>? ascend5;
  List<Items>? ascend6;

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        ascend1:
            List<Items>.from(json["ascend1"].map((x) => Items.fromJson(x))),
        ascend2:
            List<Items>.from(json["ascend2"].map((x) => Items.fromJson(x))),
        ascend3:
            List<Items>.from(json["ascend3"].map((x) => Items.fromJson(x))),
        ascend4:
            List<Items>.from(json["ascend4"].map((x) => Items.fromJson(x))),
        ascend5: json["ascend5"] == null
            ? null
            : List<Items>.from(json["ascend5"].map((x) => Items.fromJson(x))),
        ascend6: json["ascend6"] == null
            ? null
            : List<Items>.from(json["ascend6"].map((x) => Items.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ascend1": List<dynamic>.from(ascend1.map((x) => x.toJson())),
        "ascend2": List<dynamic>.from(ascend2.map((x) => x.toJson())),
        "ascend3": List<dynamic>.from(ascend3.map((x) => x.toJson())),
        "ascend4": List<dynamic>.from(ascend4.map((x) => x.toJson())),
        "ascend5": ascend5 == null
            ? null
            : List<dynamic>.from(ascend5!.map((x) => x.toJson())),
        "ascend6": ascend6 == null
            ? null
            : List<dynamic>.from(ascend6!.map((x) => x.toJson())),
      };
}

class ImageWeapon {
  final String filenameIcon;
  final String filenameAwakenIcon;
  final String filenameGacha;
  final String? mihoyoIcon;
  final String? mihoyoAwakenIcon;

  ImageWeapon({
    required this.filenameIcon,
    required this.filenameAwakenIcon,
    required this.filenameGacha,
    this.mihoyoIcon,
    this.mihoyoAwakenIcon,
  });

  factory ImageWeapon.fromJson(Map<String, dynamic> json) => ImageWeapon(
        filenameIcon: json["filename_icon"],
        filenameAwakenIcon: json["filename_awakenIcon"],
        filenameGacha: json["filename_gacha"],
        mihoyoIcon: json["mihoyo_icon"],
        mihoyoAwakenIcon: json["mihoyo_awakenIcon"],
      );

  Map<String, dynamic> toJson() => {
        "filename_icon": filenameIcon,
        "filename_awakenIcon": filenameAwakenIcon,
        "filename_gacha": filenameGacha,
        "mihoyo_icon": mihoyoIcon,
        "mihoyo_awakenIcon": mihoyoAwakenIcon,
      };
}

class Stat {
  Stat({
    required this.level,
    required this.ascension,
    required this.bonus,
    required this.attack,
    required this.specialized,
  });

  int level;
  int ascension;
  bool bonus;
  double attack;
  double specialized;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        level: json["level"],
        ascension: json["ascension"],
        bonus: json["bonus"],
        attack: json["attack"].toDouble(),
        specialized: json["specialized"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "ascension": ascension,
        "bonus": bonus,
        "attack": attack,
        "specialized": specialized,
      };
}
