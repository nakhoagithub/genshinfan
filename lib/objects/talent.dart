import 'package:genshinfan/objects/items.dart';

class Talent {
  Talent({
    required this.id,
    required this.name,
    required this.combat1,
    required this.combat2,
    this.combatsp,
    required this.combat3,
    required this.passive1,
    required this.passive2,
    this.passive3,
    this.passive4,
    required this.costs,
    this.imageTalent,
    this.element,
  });

  final int id;
  final String name;
  final CombatTalenDetail combat1;
  final CombatTalenDetail combat2;
  final CombatTalenDetail? combatsp;
  final CombatTalenDetail combat3;
  final PassiveTalenDetail passive1;
  final PassiveTalenDetail passive2;
  final PassiveTalenDetail? passive3;
  final PassiveTalenDetail? passive4;
  final Map<String, List<Items>> costs;
  ImageTalent? imageTalent;

  String? element;

  factory Talent.fromJson(Map<String, dynamic> json) => Talent(
        id: json['id'],
        name: json["name"],
        combat1: CombatTalenDetail.fromJson(json["combat1"]),
        combat2: CombatTalenDetail.fromJson(json["combat2"]),
        combatsp: json["combatsp"] == null
            ? null
            : CombatTalenDetail.fromJson(json["combatsp"]),
        combat3: CombatTalenDetail.fromJson(json["combat3"]),
        passive1: PassiveTalenDetail.fromJson(json["passive1"]),
        passive2: PassiveTalenDetail.fromJson(json["passive2"]),
        passive3: json["passive3"] == null
            ? null
            : PassiveTalenDetail.fromJson(json["passive3"]),
        passive4: json["passive4"] == null
            ? null
            : PassiveTalenDetail.fromJson(json["passive4"]),
        costs: Map.from(json["costs"]).map((k, v) =>
            MapEntry<String, List<Items>>(
                k, List<Items>.from(v.map((x) => Items.fromJson(x))))),
        imageTalent: json['images'] == null
            ? null
            : ImageTalent.fromJson(json['images']),
        element: json['element'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "combat1": combat1.toJson(),
        "combat2": combat2.toJson(),
        "combatsp": combatsp?.toJson(),
        "combat3": combat3.toJson(),
        "passive1": passive1.toJson(),
        "passive2": passive2.toJson(),
        "passive3": passive3?.toJson(),
        "passive4": passive4?.toJson(),
        "costs": Map.from(costs).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "images": imageTalent?.toJson(),
        "element": element,
      };
}

class CombatTalenDetail {
  CombatTalenDetail({
    required this.name,
    required this.descriptionRaw,
    required this.description,
    this.flavorText,
    this.attrs,
  });

  final String name;
  final String descriptionRaw;
  final String description;
  final String? flavorText;
  List<Attribute?>? attrs;

  factory CombatTalenDetail.fromJson(Map<String, dynamic> json) {
    return CombatTalenDetail(
      name: json["name"],
      descriptionRaw: json["descriptionRaw"],
      description: json["description"],
      flavorText: json['flavorText'],
      attrs: json["attrs"] == null
          ? null
          : List<Attribute>.from(
              json["attrs"].map((x) => Attribute.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "descriptionRaw": descriptionRaw,
        "description": description,
        "flavorText": flavorText,
        "attrs": attrs == null
            ? null
            : List<dynamic>.from(attrs!.map((e) => e?.toJson())),
      };
}

class Attribute {
  Attribute({
    required this.name,
    required this.params,
  });

  String name;
  List<String> params;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        name: json['label'],
        params: List<String>.from(json["params"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "label": name,
        "params": List<String>.from(params.map((x) => x)),
      };
}

class PassiveTalenDetail {
  PassiveTalenDetail({
    required this.name,
    required this.descriptionRaw,
    required this.description,
  });

  final String name;
  final String descriptionRaw;
  final String description;

  factory PassiveTalenDetail.fromJson(Map<String, dynamic> json) =>
      PassiveTalenDetail(
        name: json["name"],
        descriptionRaw: json["descriptionRaw"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "descriptionRaw": descriptionRaw,
        "description": description,
      };
}

class ImageTalent {
  ImageTalent({
    required this.filenameCombat1,
    required this.filenameCombat2,
    this.filenameCombatsp,
    required this.filenameCombat3,
    required this.filenamePassive1,
    required this.filenamePassive2,
    this.filenamePassive3,
    this.filenamePassive4,
  });

  final String filenameCombat1;
  final String filenameCombat2;
  final String? filenameCombatsp;
  final String filenameCombat3;
  final String filenamePassive1;
  final String filenamePassive2;
  final String? filenamePassive3;
  final String? filenamePassive4;

  factory ImageTalent.fromJson(Map<String, dynamic> json) => ImageTalent(
        filenameCombat1: json["filename_combat1"],
        filenameCombat2: json["filename_combat2"],
        filenameCombatsp: json["filename_combatsp"],
        filenameCombat3: json["filename_combat3"],
        filenamePassive1: json["filename_passive1"],
        filenamePassive2: json["filename_passive2"],
        filenamePassive3: json["filename_passive3"],
        filenamePassive4: json["filename_passive4"],
      );

  Map<String, dynamic> toJson() => {
        "filename_combat1": filenameCombat1,
        "filename_combat2": filenameCombat2,
        "filename_combatsp": filenameCombatsp,
        "filename_combat3": filenameCombat3,
        "filename_passive1": filenamePassive1,
        "filename_passive2": filenamePassive2,
        "filename_passive3": filenamePassive3,
        "filename_passive4": filenamePassive4,
      };
}
