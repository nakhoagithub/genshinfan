class Index {
  final Map<String, String> namemap;
  final Map<String, String> names;
  final Map<String, String> aliases;
  final Map<String, List<String>> categories;
  final Properties properties;

  Index({
    required this.namemap,
    required this.names,
    required this.aliases,
    required this.categories,
    required this.properties,
  });

  factory Index.fromJson(Map<String, dynamic> json) => Index(
        namemap: json["namemap"] == null
            ? {}
            : Map.from(json["namemap"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        names: json["names"] == null
            ? {}
            : Map.from(json["names"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        aliases: json["aliases"] == null
            ? {}
            : Map.from(json["aliases"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        categories: json["categories"] == null
            ? {}
            : Map.from(json["categories"]).map((k, v) =>
                MapEntry<String, List<String>>(
                    k, List<String>.from(v.map((x) => x)))),
        properties: json["properties"] == null
            ? Properties.fromJson({})
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "namemap":
            Map.from(namemap).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "names": Map.from(names).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "aliases":
            Map.from(aliases).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "categories": Map.from(categories).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "properties": properties.toJson(),
      };
}

class Properties {
  final List<String> rarity;
  final List<String> element;
  final List<String> weapontype;
  final List<String> substat;
  final List<String> gender;
  final List<String> costs;
  final List<String> region;
  final List<String> birthday;

  Properties({
    required this.rarity,
    required this.element,
    required this.weapontype,
    required this.substat,
    required this.gender,
    required this.costs,
    required this.region,
    required this.birthday,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        rarity: json["rarity"] == null
            ? []
            : List<String>.from(
                (json["rarity"] as List<dynamic>).map((x) => x)),
        element: json["element"] == null
            ? []
            : List<String>.from(
                (json["element"] as List<dynamic>).map((x) => x)),
        weapontype: json["weapontype"] == null
            ? []
            : List<String>.from(
                (json["weapontype"] as List<dynamic>).map((x) => x)),
        substat: json["substat"] == null
            ? []
            : List<String>.from(
                (json["substat"] as List<dynamic>).map((x) => x)),
        gender: json["gender"] == null
            ? []
            : List<String>.from(
                (json["gender"] as List<dynamic>).map((x) => x)),
        costs: json["costs"] == null
            ? []
            : List<String>.from((json["costs"] as List<dynamic>).map((x) => x)),
        region: json["region"] == null
            ? []
            : List<String>.from(
                (json["region"] as List<dynamic>).map((x) => x)),
        birthday: json["birthday"] == null
            ? []
            : List<String>.from(
                (json["birthday"] as List<dynamic>).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "rarity": List<dynamic>.from(rarity.map((x) => x)),
        "element": List<dynamic>.from(element.map((x) => x)),
        "weapontype": List<dynamic>.from(weapontype.map((x) => x)),
        "substat": List<dynamic>.from(substat.map((x) => x)),
        "gender": List<dynamic>.from(gender.map((x) => x)),
        "costs": List<dynamic>.from(costs.map((x) => x)),
        "region": List<dynamic>.from(region.map((x) => x)),
        "birthday": List<dynamic>.from(birthday.map((x) => x)),
      };
}
