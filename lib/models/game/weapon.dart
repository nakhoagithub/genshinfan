import 'package:genshinfan/models/game/items.dart';
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
    required this.name,
    this.dupealias,
    required this.description,
    required this.weapontype,
    required this.rarity,
    required this.story,
    this.baseatk,
    required this.substat,
    required this.subvalue,
    required this.effectname,
    required this.effect,
    required this.r1,
    required this.r2,
    required this.r3,
    required this.r4,
    required this.r5,
    required this.weaponmaterialtype,
    required this.costs,
    this.images,
    this.stats,
    this.specialized,
    this.version,
  });

  String? key;
  final String name;
  final String? dupealias;
  final String description;
  final String weapontype;
  final String rarity;
  final String story;
  final int? baseatk;
  final String substat;
  final String subvalue;
  final String effectname;
  final String effect;
  final List<String> r1;
  final List<String> r2;
  final List<String> r3;
  final List<String> r4;
  final List<String> r5;
  final String weaponmaterialtype;
  Costs? costs;
  ImageWeapon? images;
  List<Stat>? stats;
  String? specialized;
  String? version;

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        key: json['key'],
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        weapontype: json["weapontype"] ?? "",
        rarity: json["rarity"] ?? "",
        story: json['story'] ?? "",
        baseatk: json["baseatk"],
        substat: json["substat"] ?? "",
        subvalue: json["subvalue"] ?? "",
        effectname: json["effectname"] ?? "",
        effect: json["effect"] ?? "",
        r1: json["r1"] == null
            ? []
            : List<String>.from(json["r1"].map((x) => x)),
        r2: json["r2"] == null
            ? []
            : List<String>.from(json["r2"].map((x) => x)),
        r3: json["r3"] == null
            ? []
            : List<String>.from(json["r3"].map((x) => x)),
        r4: json["r4"] == null
            ? []
            : List<String>.from(json["r4"].map((x) => x)),
        r5: json["r5"] == null
            ? []
            : List<String>.from(json["r5"].map((x) => x)),
        weaponmaterialtype: json["weaponmaterialtype"] ?? "",
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
        "name": name,
        "description": description,
        "weapontype": weapontype,
        "rarity": rarity,
        "story": story,
        "baseatk": baseatk,
        "substat": substat,
        "subvalue": subvalue,
        "effectname": effectname,
        "effect": effect,
        "r1": List<dynamic>.from(r1.map((x) => x)),
        "r2": List<dynamic>.from(r2.map((x) => x)),
        "r3": List<dynamic>.from(r3.map((x) => x)),
        "r4": List<dynamic>.from(r4.map((x) => x)),
        "r5": List<dynamic>.from(r5.map((x) => x)),
        "weaponmaterialtype": weaponmaterialtype,
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
        ascend1: json["ascend1"] == null
            ? []
            : List<Items>.from(json["ascend1"].map((x) => Items.fromJson(x))),
        ascend2: json["ascend2"] == null
            ? []
            : List<Items>.from(json["ascend2"].map((x) => Items.fromJson(x))),
        ascend3: json["ascend3"] == null
            ? []
            : List<Items>.from(json["ascend3"].map((x) => Items.fromJson(x))),
        ascend4: json["ascend4"] == null
            ? []
            : List<Items>.from(json["ascend4"].map((x) => Items.fromJson(x))),
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
  final String nameicon;
  final String namegacha;
  final String nameawakenicon;
  final String? image;
  final String? icon;
  final String? awakenicon;

  ImageWeapon({
    required this.nameicon,
    required this.namegacha,
    required this.nameawakenicon,
    this.image,
    this.icon,
    this.awakenicon,
  });

  factory ImageWeapon.fromJson(Map<String, dynamic> json) => ImageWeapon(
        nameicon: json["nameicon"] ?? "",
        namegacha: json["namegacha"] ?? "",
        nameawakenicon: json["nameawakenicon"] ?? "",
        image: json["image"],
        icon: json["icon"],
        awakenicon: json["awakenicon"],
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
        "namegacha": namegacha,
        "nameawakenicon": nameawakenicon,
        "image": image,
        "icon": icon,
        "awakenicon": awakenicon,
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
        level: json["level"] ?? 0,
        ascension: json["ascension"] ?? 0,
        bonus: json["bonus"] ?? false,
        attack: json["attack"]?.toDouble() ?? 0.0,
        specialized: json["specialized"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "ascension": ascension,
        "bonus": bonus,
        "attack": attack,
        "specialized": specialized,
      };
}
