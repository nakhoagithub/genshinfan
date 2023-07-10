import 'package:genshinfan/models/game/image_food.dart';

class Food {
  String? key;
  final String name;
  final String rarity;
  final String foodtype;
  final String foodfilter;
  final String foodcategory;
  final String effect;
  final String description;
  final String basedish;
  final String character;
  final FoodQuality? suspicious;
  final FoodQuality? normal;
  final FoodQuality? delicious;
  final List<FoodIngredient> ingredients;
  ImageFood? images;
  String? version;

  Food({
    this.key,
    required this.name,
    required this.rarity,
    required this.foodtype,
    required this.foodfilter,
    required this.foodcategory,
    required this.effect,
    required this.description,
    required this.basedish,
    required this.character,
    required this.suspicious,
    required this.normal,
    required this.delicious,
    required this.ingredients,
    this.images,
    this.version,
  });

  void setImage(dynamic json) {
    images = ImageFood.fromJson(json);
  }

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        key: json['key'] ?? "",
        name: json["name"] ?? "",
        rarity: json["rarity"] ?? "",
        foodtype: json["foodtype"] ?? "",
        foodfilter: json["foodfilter"] ?? "",
        foodcategory: json["foodcategory"] ?? "",
        effect: json["effect"] ?? "",
        description: json["description"] ?? "",
        basedish: json["basedish"] ?? "",
        character: json["character"] ?? "",
        suspicious: json["suspicious"] == null
            ? null
            : FoodQuality.fromJson(json["suspicious"]),
        normal: json["normal"] == null
            ? null
            : FoodQuality.fromJson(json["normal"]),
        delicious: json["delicious"] == null
            ? null
            : FoodQuality.fromJson(json["delicious"]),
        ingredients: List<FoodIngredient>.from(
            json["ingredients"].map((x) => FoodIngredient.fromJson(x))),
        images:
            json['images'] == null ? null : ImageFood.fromJson(json['images']),
        version: json['version'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "rarity": rarity,
        "foodtype": foodtype,
        "foodfilter": foodfilter,
        "foodcategory": foodcategory,
        "effect": effect,
        "description": description,
        "basedish": basedish,
        "character": character,
        "suspicious": suspicious?.toJson(),
        "normal": normal?.toJson(),
        "delicious": delicious?.toJson(),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "images": images?.toJson(),
        "version": version,
      };
}

class FoodQuality {
  final String effect;
  final String description;

  FoodQuality({
    required this.effect,
    required this.description,
  });

  factory FoodQuality.fromJson(Map<String, dynamic> json) => FoodQuality(
        effect: json["effect"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "effect": effect,
        "description": description,
      };
}

class FoodIngredient {
  final String name;
  final int count;

  FoodIngredient({
    required this.name,
    required this.count,
  });

  factory FoodIngredient.fromJson(Map<String, dynamic> json) => FoodIngredient(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}
