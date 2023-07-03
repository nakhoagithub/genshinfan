import 'package:genshinfan/models/items.dart';

class Talent {
  Talent({
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
    required this.info,
    this.description,
    this.attrs,
  });

  final String name;
  final String info;
  final String? description;
  List<Attribute?>? attrs;

  factory CombatTalenDetail.fromJson(Map<String, dynamic> json) {
    return CombatTalenDetail(
      name: json["name"],
      info: json["info"],
      description: json["description"],
      attrs: json["attrs"] == null
          ? null
          : List<Attribute>.from(
              json["attrs"].map((x) => Attribute.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "info": info,
        "description": description,
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
    required this.info,
  });

  final String name;
  final String info;

  factory PassiveTalenDetail.fromJson(Map<String, dynamic> json) =>
      PassiveTalenDetail(
        name: json["name"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "info": info,
      };
}

class ImageTalent {
  ImageTalent({
    required this.combat1,
    required this.combat2,
    this.combatsp,
    required this.combat3,
    required this.passive1,
    required this.passive2,
    this.passive3,
    this.passive4,
  });

  final String combat1;
  final String combat2;
  final String? combatsp;
  final String combat3;
  final String passive1;
  final String passive2;
  final String? passive3;
  final String? passive4;

  factory ImageTalent.fromJson(Map<String, dynamic> json) => ImageTalent(
        combat1: json["combat1"],
        combat2: json["combat2"],
        combatsp: json["combatsp"],
        combat3: json["combat3"],
        passive1: json["passive1"],
        passive2: json["passive2"],
        passive3: json["passive3"],
        passive4: json["passive4"],
      );

  Map<String, dynamic> toJson() => {
        "combat1": combat1,
        "combat2": combat2,
        "combatsp": combatsp,
        "combat3": combat3,
        "passive1": passive1,
        "passive2": passive2,
        "passive3": passive3,
        "passive4": passive4,
      };
}
