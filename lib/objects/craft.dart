class Craft {
  final String name;
  final String filter;
  final int sortorder;
  final int unlockrank;
  final int resultcount;
  final int? moracost;
  final List<CraftIngredient> recipe;
  final List<List<CraftIngredient>>? altrecipes;
  String? version;

  Craft({
    required this.name,
    required this.filter,
    required this.sortorder,
    required this.unlockrank,
    required this.resultcount,
    this.moracost,
    required this.recipe,
    this.altrecipes,
    this.version,
  });

  factory Craft.fromJson(Map<String, dynamic> json) => Craft(
        name: json["name"],
        filter: json["filter"],
        sortorder: json["sortorder"],
        unlockrank: json["unlockrank"],
        resultcount: json["resultcount"],
        moracost: json["moracost"],
        recipe: List<CraftIngredient>.from(
            json["recipe"].map((x) => CraftIngredient.fromJson(x))),
        altrecipes: json["altrecipes"] == null
            ? null
            : List<List<CraftIngredient>>.from(json["altrecipes"].map((x) =>
                List<CraftIngredient>.from(
                    x.map((x) => CraftIngredient.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
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
        name: json["name"],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}
