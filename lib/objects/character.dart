import 'dart:convert';

import '../resources/utils/tools.dart';
import 'image.dart';
import 'image_constellation.dart';
import 'image_talent.dart';
import 'talent.dart';

class Character {
  Character({
    this.id,
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
  });
  String? id;
  String name;
  String fullname;
  String title;
  String description;
  String rarity;
  String element;
  String weapontype;
  String substat;
  String gender;
  String body;
  String association;
  String region;
  String affiliation;
  String birthdaymmdd;
  String birthday;
  String constellation;
  Cv cv;
  Costs costs;
  Image? images;
  Talent? talent;
  List<Talent>? talentTravelers;
  Constellations? constellations;
  List<Constellations>? constellationTravelers;
  List<Stat>? stats;
  String? specialized;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
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
        constellationTravelers: json["constellationTravelers"] == null
            ? null
            : List<Constellations>.from(json["constellationTravelers"]
                .map((x) => Constellations.fromJson(x))),
        cv: Cv.fromMap(json["cv"]),
        costs: Costs.fromJson(json["costs"]),
        images: json['images'] == null ? null : Image.fromJson(json['images']),
        talent: json['talent'] == null ? null : Talent.fromJson(json['talent']),
        talentTravelers: json["talentTravelers"] == null
            ? null
            : List<Talent>.from(
                json["talentTravelers"].map((x) => Talent.fromJson(x))),
        constellations: json['constellations'] == null
            ? null
            : Constellations.fromJson(json['constellations']),
        stats: json["stats"] == null
            ? null
            : List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        specialized: json['specialized'],
      );

  Map<String, dynamic> toJson() => {
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
        "cv": cv.toMap(),
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
      };

  void setImage(dynamic json) {
    images = Image.fromJson(json);
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
      constellations = Constellations.fromJson(json[id]);
      constellations?.imageConstellation =
          ImageConstellation.fromJson(imageConstellation[id]);
    } else {
      List<Constellations> listConstellation = [];
      for (var e in json.keys) {
        if (e.contains('traveler')) {
          Constellations c = Constellations.fromJson(json[e]);
          c.imageConstellation =
              ImageConstellation.fromJson(imageConstellation[e]);
          listConstellation.add(c);
        }
      }
      constellationTravelers = listConstellation;
    }
  }

  dynamic _baseStat(
    List<dynamic> listData,
    dynamic stat,
    dynamic curve,
    dynamic curveCharacter,
    dynamic promotion,
    dynamic lv,
    int ascension,
    bool bonus,
  ) {
    // add base character
    if (lv == 1) {
      dynamic output = {
        "level": lv,
        "ascension": ascension,
        "bonus": bonus,
        "hp": stat['base']['hp'],
        "attack": stat['base']['attack'],
        "defense": stat['base']['defense'],
        "specialized": 0,
      };
      if (stat['specialized'] == 'FIGHT_PROP_CRITICAL') {
        output['specialized'] += stat['base']['critrate'];
      } else if (stat['specialized'] == 'FIGHT_PROP_CRITICAL_HURT') {
        output['specialized'] += stat['base']['critdmg'];
      }
      listData.add(Stat.fromJson(output));
    } else {
      dynamic output = {
        "level": lv,
        "ascension": ascension,
        "bonus": bonus,
        "hp": stat['base']['hp'] * curve["$lv"][curveCharacter['hp']] +
            promotion['hp'],
        "attack":
            stat['base']['attack'] * curve["$lv"][curveCharacter['attack']] +
                promotion['attack'],
        "defense":
            stat['base']['defense'] * curve["$lv"][curveCharacter['defense']] +
                promotion['defense'],
        "specialized": promotion['specialized']
      };
      if (stat['specialized'] == 'FIGHT_PROP_CRITICAL') {
        output['specialized'] += stat['base']['critrate'];
      } else if (stat['specialized'] == 'FIGHT_PROP_CRITICAL_HURT') {
        output['specialized'] += stat['base']['critdmg'];
      }
      listData.add(Stat.fromJson(output));
    }
  }

  /// `stat`: base của nhân vật
  ///
  /// `curve`: base của tất cả nhân vật
  void setStat(dynamic stat, dynamic curve) {
    List<Stat> listData = [];
    List<dynamic> promotions = stat['promotion'];
    _baseStat(listData, stat, curve, stat['curve'], promotions[0], 1, 0, false);
    for (int i = 0; i < promotions.length; i++) {
      _baseStat(listData, stat, curve, stat['curve'], promotions[i],
          promotions[i]['maxlevel'], i, false);
      if (promotions[i]['maxlevel'] != 90) {
        _baseStat(listData, stat, curve, stat['curve'], promotions[i + 1],
            promotions[i]['maxlevel'], i + 1, true);
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
    required this.ascend5,
    required this.ascend6,
  });

  List<AscendCharacter> ascend1;
  List<AscendCharacter> ascend2;
  List<AscendCharacter> ascend3;
  List<AscendCharacter> ascend4;
  List<AscendCharacter> ascend5;
  List<AscendCharacter> ascend6;

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        ascend1: List<AscendCharacter>.from(
            json["ascend1"].map((x) => AscendCharacter.fromJson(x))),
        ascend2: List<AscendCharacter>.from(
            json["ascend2"].map((x) => AscendCharacter.fromJson(x))),
        ascend3: List<AscendCharacter>.from(
            json["ascend3"].map((x) => AscendCharacter.fromJson(x))),
        ascend4: List<AscendCharacter>.from(
            json["ascend4"].map((x) => AscendCharacter.fromJson(x))),
        ascend5: List<AscendCharacter>.from(
            json["ascend5"].map((x) => AscendCharacter.fromJson(x))),
        ascend6: List<AscendCharacter>.from(
            json["ascend6"].map((x) => AscendCharacter.fromJson(x))),
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

class AscendCharacter {
  AscendCharacter({
    required this.name,
    required this.count,
  });

  String? name;
  int? count;

  factory AscendCharacter.fromJson(Map<String, dynamic> json) =>
      AscendCharacter(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}

class Cv {
  Cv({
    required this.english,
    required this.chinese,
    required this.japanese,
    required this.korean,
  });

  String english;
  String chinese;
  String japanese;
  String korean;

  factory Cv.fromJson(String str) => Cv.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cv.fromMap(Map<String, dynamic> json) => Cv(
        english: json["english"],
        chinese: json["chinese"],
        japanese: json["japanese"],
        korean: json["korean"],
      );

  Map<String, dynamic> toMap() => {
        "english": english,
        "chinese": chinese,
        "japanese": japanese,
        "korean": korean,
      };
}

class Constellations {
  Constellations({
    required this.name,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    this.imageConstellation,
  });

  String name;
  Constellation c1;
  Constellation c2;
  Constellation c3;
  Constellation c4;
  Constellation c5;
  Constellation c6;
  ImageConstellation? imageConstellation;

  factory Constellations.fromJson(Map<String, dynamic> json) => Constellations(
        name: json["name"],
        c1: Constellation.fromJson(json["c1"]),
        c2: Constellation.fromJson(json["c2"]),
        c3: Constellation.fromJson(json["c3"]),
        c4: Constellation.fromJson(json["c4"]),
        c5: Constellation.fromJson(json["c5"]),
        c6: Constellation.fromJson(json["c6"]),
        imageConstellation: json["images"] == null
            ? null
            : ImageConstellation.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "c1": c1.toJson(),
        "c2": c2.toJson(),
        "c3": c3.toJson(),
        "c4": c4.toJson(),
        "c5": c5.toJson(),
        "c6": c6.toJson(),
        "images": imageConstellation?.toJson(),
      };
}

class Constellation {
  Constellation({
    required this.name,
    required this.effect,
  });

  String name;
  String effect;

  factory Constellation.fromJson(Map<String, dynamic> json) => Constellation(
        name: json["name"],
        effect: json["effect"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "effect": effect,
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
