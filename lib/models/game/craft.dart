import 'package:genshinfan/models/game/resource.dart';

class Craft {
  String? key;
  final String name;
  final String? filter;
  final int sortorder;
  final int unlockrank;
  final int resultcount;
  final int? moracost;
  final List<CraftIngredient> recipe;
  final List<List<CraftIngredient>>? altrecipes;
  String? version;
  Resource? resource;

  Craft({
    this.key,
    required this.name,
    this.filter,
    required this.sortorder,
    required this.unlockrank,
    required this.resultcount,
    this.moracost,
    required this.recipe,
    this.altrecipes,
    this.version,
    this.resource,
  });

  factory Craft.fromJson(Map<String, dynamic> json) => Craft(
        key: json['key'],
        name: json["name"] ?? "",
        filter: json["filter"],
        sortorder: json["sortorder"] ?? 0,
        unlockrank: json["unlockrank"] ?? 0,
        resultcount: json["resultcount"] ?? 0,
        moracost: json["moracost"],
        recipe: json["recipe"] == null
            ? []
            : List<CraftIngredient>.from(
                json["recipe"].map((x) => CraftIngredient.fromJson(x))),
        altrecipes: json["altrecipes"] == null
            ? null
            : List<List<CraftIngredient>>.from(json["altrecipes"].map((x) =>
                List<CraftIngredient>.from(
                    x.map((x) => CraftIngredient.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "filter": filter,
        "sortorder": sortorder,
        "unlockrank": unlockrank,
        "resultcount": resultcount,
        "recipe": List<dynamic>.from(recipe.map((x) => x.toJson())),
        "altrecipes": altrecipes == null
            ? null
            : List<dynamic>.from(altrecipes!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class CraftIngredient {
  final String name;
  final int count;

  const CraftIngredient({
    required this.name,
    required this.count,
  });

  factory CraftIngredient.fromJson(Map<String, dynamic> json) =>
      CraftIngredient(
        name: json["name"] ?? "",
        count: json['count'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}
