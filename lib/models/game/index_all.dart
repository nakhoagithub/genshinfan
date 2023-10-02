import 'package:genshinfan/models/game/index.dart';

class IndexAll {
  final Index character;
  final Index weapon;
  final Index resource;
  final Index artifact;
  final Index food;
  final Index domain;
  final Index enemy;
  final Index achievement;
  final Index windglider;
  final Index animal;
  final Index namecard;
  final Index geography;
  final Index adventurerank;
  final Index craft;
  final Index outfit;

  const IndexAll({
    required this.character,
    required this.weapon,
    required this.resource,
    required this.artifact,
    required this.food,
    required this.domain,
    required this.enemy,
    required this.achievement,
    required this.windglider,
    required this.animal,
    required this.namecard,
    required this.geography,
    required this.adventurerank,
    required this.craft,
    required this.outfit,
  });

  factory IndexAll.fromJson(Map<String, dynamic> json) => IndexAll(
        character: json["characters"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["characters"]),
        weapon: json["weapons"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["weapons"]),
        resource: json["materials"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["materials"]),
        artifact: json["artifacts"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["artifacts"]),
        food: json["foods"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["foods"]),
        domain: json["domains"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["domains"]),
        enemy: json["enemies"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["enemies"]),
        achievement: json["achievements"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["achievements"]),
        windglider: json["windgliders"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["windgliders"]),
        animal: json["animals"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["animals"]),
        namecard: json["namecards"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["namecards"]),
        geography: json["geographies"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["geographies"]),
        adventurerank: json["adventureranks"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["adventureranks"]),
        craft: json["crafts"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["crafts"]),
        outfit: json["outfits"] == null
            ? Index.fromJson({})
            : Index.fromJson(json["outfits"]),
      );

  Map<String, dynamic> toJson() => {
        "characters": character.toJson(),
        "weapons": weapon.toJson(),
        "materials": resource.toJson(),
        "artifacts": artifact.toJson(),
        "foods": food.toJson(),
        "domains": domain.toJson(),
        "enemies": enemy.toJson(),
        "achievements": achievement.toJson(),
        "windgliders": windglider.toJson(),
        "animals": animal.toJson(),
        "namecards": namecard.toJson(),
        "geographies": geography.toJson(),
        "adventureranks": adventurerank.toJson(),
        "crafts": craft.toJson(),
        "outfits": outfit.toJson(),
      };
}
