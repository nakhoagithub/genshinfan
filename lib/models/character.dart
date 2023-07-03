import 'package:genshinfan/models/constellation.dart';
import 'package:genshinfan/models/items.dart';
import 'package:genshinfan/models/url.dart';

import '../utils/tools.dart';
import 'talent.dart';

List<int> levels = [
  1,
  20,
  -20,
  40,
  -40,
  50,
  -50,
  60,
  -60,
  70,
  -70,
  80,
  -80,
  90,
];

List<int> ascensions = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6];

class Character {
  Character({
    this.key,
    required this.name,
    required this.fullname,
    required this.title,
    required this.description,
    required this.rarity,
    required this.element,
    required this.weapontype,
    required this.substat,
    required this.gender,
    required this.body,
    required this.association,
    required this.region,
    required this.affiliation,
    required this.birthdaymmdd,
    required this.birthday,
    required this.constellation,
    this.constellationTravelers,
    required this.cv,
    required this.costs,
    this.images,
    this.talent,
    this.talentTravelers,
    this.constellations,
    this.stats,
    this.specialized,
    this.url,
    this.version,
  });

  String? key;
  final String name;
  final String? fullname;
  final String title;
  final String description;
  final String rarity;
  final String element;
  final String weapontype;
  final String substat;
  final String gender;
  final String body;
  final String association;
  final String region;
  final String affiliation;
  final String birthdaymmdd;
  final String birthday;
  final String constellation;
  Cv cv;
  Costs costs;
  ImageCharacter? images;
  Talent? talent;
  List<Talent>? talentTravelers;
  Constellation? constellations;
  List<Constellation>? constellationTravelers;
  List<Stat>? stats;
  String? specialized;
  UrlObject? url;
  String? version;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        key: json['key'],
        name: json["name"],
        fullname: json["fullname"],
        title: json["title"],
        description: json["description"],
        rarity: json["rarity"],
        element: json["element"],
        weapontype: json["weapontype"],
        substat: json["substat"],
        gender: json["gender"],
        body: json["body"],
        association: json["association"],
        region: json["region"],
        affiliation: json["affiliation"],
        birthdaymmdd: json["birthdaymmdd"],
        birthday: json["birthday"],
        constellation: json["constellation"],
        cv: Cv.fromJson(json["cv"]),
        costs: Costs.fromJson(json["costs"]),
        images: json['images'] == null
            ? null
            : ImageCharacter.fromJson(json['images']),
        talent: json['talent'] == null ? null : Talent.fromJson(json['talent']),
        talentTravelers: json["talentTravelers"] == null
            ? null
            : List<Talent>.from(
                json["talentTravelers"].map((x) => Talent.fromJson(x))),
        constellations: json['constellations'] == null
            ? null
            : Constellation.fromJson(json['constellations']),
        constellationTravelers: json["constellationTravelers"] == null
            ? null
            : List<Constellation>.from(json["constellationTravelers"]
                .map((x) => Constellation.fromJson(x))),
        stats: json["stats"] == null
            ? null
            : List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        specialized: json['specialized'],
        url: json['url'] == null ? null : UrlObject.fromJson(json['url']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "fullname": fullname,
        "title": title,
        "description": description,
        "rarity": rarity,
        "element": element,
        "weapontype": weapontype,
        "substat": substat,
        "gender": gender,
        "body": body,
        "association": association,
        "region": region,
        "affiliation": affiliation,
        "birthdaymmdd": birthdaymmdd,
        "birthday": birthday,
        "constellation": constellation,
        "constellationTravelers": constellationTravelers == null
            ? null
            : List<dynamic>.from(
                constellationTravelers!.map((e) => e.toJson())),
        "cv": cv.toJson(),
        "costs": costs.toJson(),
        "images": images?.toJson(),
        "talent": talent?.toJson(),
        "talentTravelers": talentTravelers == null
            ? null
            : List<dynamic>.from(talentTravelers!.map((e) => e.toJson())),
        "constellations": constellations?.toJson(),
        "stats": stats == null
            ? null
            : List<dynamic>.from(stats!.map((x) => x.toJson())),
        "specialized": specialized,
        "url": url?.toJson(),
        "version": version,
      };

  void setImage(dynamic json) {
    images = ImageCharacter.fromJson(json);
  }

  String _handleParameter(num value, String format) {
    String result = value.toString();
    // integer
    if (format == "I") {
      // số nguyên
    }
    // percent
    if (format.contains("P")) {
      result = (value * 100.0).toString();
    }
    // format số thập phân
    if (format.contains("F") || format.contains("P")) {
      if (value is int) {
        result = num.parse(result).toStringAsFixed(0);
      } else {
        result = num.parse(result).toStringAsFixed(2);
      }
    }
    // percent thêm %
    if (format.contains("P")) {
      result = "$result%";
    }
    return result;
  }

  List<Attribute>? _setAttributeCombat(
      String combat, dynamic stat, dynamic talentJson) {
    dynamic lbcb = talentJson[combat]['attributes']['labels'];
    RegExp rx = RegExp(r'\{(.*?)\}');
    List<Attribute> attrs = [];
    if (lbcb != null) {
      for (String e in lbcb) {
        // name
        String name = e.substring(0, e.indexOf('|'));

        // phần còn lại
        String label = e.substring(e.indexOf('|') + 1);
        Iterable<Match> matches = rx.allMatches(label);
        List<String> params = [];
        // 15 cấp
        for (int i = 0; i < 15; i++) {
          String l = label;
          for (Match m in matches) {
            String match = m[0]!;
            List<String> paranum =
                match.substring(1, match.length - 1).split(':');
            List<dynamic> dataParameter = stat[combat][paranum[0]];
            if (dataParameter.length == 15) {
              l = l.replaceAll("{${paranum[0]}:${paranum[1]}}",
                  _handleParameter(dataParameter[i], paranum[1]));
            } else {
              l = l.replaceAll("{${paranum[0]}:${paranum[1]}}",
                  _handleParameter(dataParameter[0], paranum[1]));
            }
          }
          params.add(l);
        }
        // đổi về json để convert nó thành object
        Map<String, dynamic> attrJson = {
          "label": name,
          "params": params,
        };
        attrs.add(Attribute.fromJson(attrJson));
      }
    }
    return attrs;
  }

  Talent _talent(
      String id, dynamic talentJson, dynamic imageTalent, dynamic stat,
      {String? element}) {
    Talent talent = Talent.fromJson(talentJson[id]);
    talent.element = element;
    talent.imageTalent = ImageTalent.fromJson(imageTalent[id]);

    talent.combat1.attrs =
        _setAttributeCombat("combat1", stat[id], talentJson[id]);
    talent.combat2.attrs =
        _setAttributeCombat("combat2", stat[id], talentJson[id]);
    talent.combat3.attrs =
        _setAttributeCombat("combat3", stat[id], talentJson[id]);

    if (talent.combatsp != null) {
      talent.combatsp!.attrs =
          _setAttributeCombat("combatsp", stat[id], talentJson[id]);
    }
    return talent;
  }

  /// `id` là lên nhân vật (key)
  ///
  /// `talentJson` là dữ liệu talent nhân vật
  ///
  /// `imageTalent` là hình ảnh talent
  ///
  /// `stat` stat talent
  void setTalent(
      String id, dynamic talentJson, dynamic imageTalent, dynamic stat) {
    // không phải nhân vật main
    if (association != "MAINACTOR") {
      talent = _talent(id, talentJson, imageTalent, stat);
    } else {
      // nhân vật main
      List<Talent> talents = [];
      for (var e in talentJson.keys) {
        if (e.contains("traveler")) {
          String element =
              (e as String).substring(e.indexOf("traveler") + 8, e.length);
          element = Tools.capitalize(element);
          talents
              .add(_talent(e, talentJson, imageTalent, stat, element: element));
        }
      }
      talentTravelers = talents;
    }
  }

  void setConstellation(String id, dynamic json, dynamic imageConstellation) {
    if (association != "MAINACTOR") {
      constellations = Constellation.fromJson(json[id]);
      constellations?.images =
          ImageConstellation.fromJson(imageConstellation[id]);
    } else {
      List<Constellation> listConstellation = [];
      for (var e in json.keys) {
        if (e.contains('traveler')) {
          Constellation c = Constellation.fromJson(json[e]);
          c.images = ImageConstellation.fromJson(imageConstellation[e]);
          listConstellation.add(c);
        }
      }
      constellationTravelers = listConstellation;
    }
  }

  void setStat(dynamic stat, dynamic curve) {
    List<Stat> listData = [];
    Map<String, dynamic> base = stat['base'];
    Map<String, dynamic> curveBase = stat['curve'];
    String spec = stat['specialized'];
    List<dynamic> promotions = stat['promotion'];
    for (int i = 0; i < levels.length; i++) {
      // level
      int level = levels[i] > 0 ? levels[i] : levels[i] * -1;

      // ascension
      int ascension = ascensions[i];

      // bonus

      // hp
      double hp = base['hp'] * curve["$level"][curveBase['hp']];
      // attack
      double attack = base['attack'] * curve["$level"][curveBase['attack']] +
          promotions[i ~/ 2]['attack'];
      // defense
      double defense = base['defense'] * curve["$level"][curveBase['defense']] +
          promotions[i ~/ 2]['defense'];
      // specialized
      double specialized =
          double.parse(promotions[i ~/ 2]['specialized'].toString());

      if (spec == 'FIGHT_PROP_CRITICAL') {
        specialized += base['critrate'];
      } else if (spec == 'FIGHT_PROP_CRITICAL_HURT') {
        specialized += base['critdmg'];
      }

      Stat stat = Stat(
        level: level,
        ascension: ascension,
        bonus: levels[i] < 0 ? true : false,
        hp: hp,
        attack: attack,
        defense: defense,
        specialized: specialized,
      );
      listData.add(stat);
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
    required this.ascend5,
    required this.ascend6,
  });

  final List<Items> ascend1;
  final List<Items> ascend2;
  final List<Items> ascend3;
  final List<Items> ascend4;
  final List<Items> ascend5;
  final List<Items> ascend6;

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        ascend1:
            List<Items>.from(json["ascend1"].map((x) => Items.fromJson(x))),
        ascend2:
            List<Items>.from(json["ascend2"].map((x) => Items.fromJson(x))),
        ascend3:
            List<Items>.from(json["ascend3"].map((x) => Items.fromJson(x))),
        ascend4:
            List<Items>.from(json["ascend4"].map((x) => Items.fromJson(x))),
        ascend5:
            List<Items>.from(json["ascend5"].map((x) => Items.fromJson(x))),
        ascend6:
            List<Items>.from(json["ascend6"].map((x) => Items.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ascend1": List<dynamic>.from(ascend1.map((x) => x.toJson())),
        "ascend2": List<dynamic>.from(ascend2.map((x) => x.toJson())),
        "ascend3": List<dynamic>.from(ascend3.map((x) => x.toJson())),
        "ascend4": List<dynamic>.from(ascend4.map((x) => x.toJson())),
        "ascend5": List<dynamic>.from(ascend5.map((x) => x.toJson())),
        "ascend6": List<dynamic>.from(ascend6.map((x) => x.toJson())),
      };
}

class Cv {
  Cv({
    required this.english,
    required this.chinese,
    required this.japanese,
    required this.korean,
  });

  final String english;
  final String chinese;
  final String japanese;
  final String korean;

  factory Cv.fromJson(Map<String, dynamic> json) => Cv(
        english: json["english"],
        chinese: json["chinese"],
        japanese: json["japanese"],
        korean: json["korean"],
      );

  Map<String, dynamic> toJson() => {
        "english": english,
        "chinese": chinese,
        "japanese": japanese,
        "korean": korean,
      };
}

class Stat {
  Stat({
    required this.level,
    required this.ascension,
    required this.bonus,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialized,
  });

  int level;
  int ascension;
  bool bonus;
  double hp;
  double attack;
  double defense;
  double specialized;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        level: json["level"],
        ascension: json["ascension"],
        bonus: json["bonus"],
        hp: json["hp"].toDouble(),
        attack: json["attack"].toDouble(),
        defense: json["defense"].toDouble(),
        specialized: json["specialized"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "ascension": ascension,
        "bonus": bonus,
        "hp": hp,
        "attack": attack,
        "defense": defense,
        "specialized": specialized,
      };
}

class ImageCharacter {
  final String? nameicon;
  final String? namesideicon;
  final String? namegachasplash;
  final String? namegachaslice;
  final String? card;
  final String? portrait;
  final String? icon;
  final String? sideicon;
  final String? cover1;
  final String? cover2;
  final String? hoyolabAvatar;

  const ImageCharacter({
    this.nameicon,
    this.namesideicon,
    this.namegachasplash,
    this.namegachaslice,
    this.card,
    this.portrait,
    this.icon,
    this.sideicon,
    this.cover1,
    this.cover2,
    this.hoyolabAvatar,
  });

  factory ImageCharacter.fromJson(Map<String, dynamic> json) => ImageCharacter(
        nameicon: json['nameicon'],
        namesideicon: json['namesideicon'],
        namegachasplash: json['namegachasplash'],
        namegachaslice: json['namegachaslice'],
        card: json['card'],
        portrait: json['portrait'],
        icon: json['icon'],
        sideicon: json['sideicon'],
        cover1: json['cover1'],
        cover2: json['cover2'],
        hoyolabAvatar: json['hoyolab-avatar'],
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
        "namesideicon": namesideicon,
        "namegachasplash": namegachasplash,
        "namegachaslice": namegachaslice,
        "card": card,
        "portrait": portrait,
        "icon": icon,
        "sideicon": sideicon,
        "cover1": cover1,
        "cover2": cover2,
        "hoyolab-avatar": hoyolabAvatar,
      };
}
