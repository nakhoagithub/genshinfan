import 'image_talent.dart';

class Talent {
  Talent({
    required this.name,
    this.element,
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
  });

  String name;
  String? element;
  Combat combat1;
  Combat combat2;
  Combat? combatsp;
  Combat combat3;
  Passive passive1;
  Passive passive2;
  Passive? passive3;
  Passive? passive4;
  Map<String, List<Cost>> costs;
  ImageTalent? imageTalent;

  factory Talent.fromJson(Map<String, dynamic> json) => Talent(
        name: json["name"],
        element: json['element'],
        combat1: Combat.fromJson(json["combat1"]),
        combat2: Combat.fromJson(json["combat2"]),
        combatsp:
            json["combatsp"] == null ? null : Combat.fromJson(json["combatsp"]),
        combat3: Combat.fromJson(json["combat3"]),
        passive1: Passive.fromJson(json["passive1"]),
        passive2: Passive.fromJson(json["passive2"]),
        passive3: json["passive3"] == null
            ? null
            : Passive.fromJson(json["passive3"]),
        passive4: json["passive4"] == null
            ? null
            : Passive.fromJson(json["passive4"]),
        costs: Map.from(json["costs"]).map((k, v) =>
            MapEntry<String, List<Cost>>(
                k, List<Cost>.from(v.map((x) => Cost.fromJson(x))))),
        imageTalent: json['images'] == null
            ? null
            : ImageTalent.fromJson(json['images']),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "element": element,
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
      };
}

class Combat {
  Combat({
    required this.name,
    required this.info,
    this.attrs,
    required this.description,
  });

  String name;
  String info;
  List<Attribute?>? attrs;
  String? description;

  factory Combat.fromJson(Map<String, dynamic> json) {
    return Combat(
      name: json["name"],
      info: json["info"],
      attrs: json["attrs"] == null
          ? null
          : List<Attribute>.from(
              json["attrs"].map((x) => Attribute.fromJson(x))),
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "info": info,
        "attrs": attrs == null
            ? null
            : List<dynamic>.from(attrs!.map((e) => e?.toJson())),
        "description": description,
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

class Cost {
  Cost({
    required this.name,
    required this.count,
  });

  String name;
  int count;

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}

class Passive {
  Passive({
    required this.name,
    required this.info,
  });

  String name;
  String info;

  factory Passive.fromJson(Map<String, dynamic> json) => Passive(
        name: json["name"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "info": info,
      };
}
