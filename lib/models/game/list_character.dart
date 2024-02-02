class CharacterRes {
  final int response;
  final CharacterData data;

  CharacterRes({
    required this.response,
    required this.data,
  });

  factory CharacterRes.fromJson(Map<String, dynamic> json) => CharacterRes(
        response: json["response"],
        data: CharacterData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "data": data.toJson(),
      };
}

class CharacterData {
  final CharacterTypes types;
  final Map<String, dynamic> items;

  CharacterData({
    required this.types,
    required this.items,
  });

  factory CharacterData.fromJson(Map<String, dynamic> json) => CharacterData(
        types: CharacterTypes.fromJson(json["types"]),
        items: json["items"],
      );

  Map<String, dynamic> toJson() => {
        "types": types.toJson(),
        "items": items,
      };
}

class CharacterTypes {
  final String weaponSwordOneHand;
  final String weaponCatalyst;
  final String weaponClaymore;
  final String weaponBow;
  final String weaponPole;

  CharacterTypes({
    required this.weaponSwordOneHand,
    required this.weaponCatalyst,
    required this.weaponClaymore,
    required this.weaponBow,
    required this.weaponPole,
  });

  factory CharacterTypes.fromJson(Map<String, dynamic> json) => CharacterTypes(
        weaponSwordOneHand: json["WEAPON_SWORD_ONE_HAND"],
        weaponCatalyst: json["WEAPON_CATALYST"],
        weaponClaymore: json["WEAPON_CLAYMORE"],
        weaponBow: json["WEAPON_BOW"],
        weaponPole: json["WEAPON_POLE"],
      );

  Map<String, dynamic> toJson() => {
        "WEAPON_SWORD_ONE_HAND": weaponSwordOneHand,
        "WEAPON_CATALYST": weaponCatalyst,
        "WEAPON_CLAYMORE": weaponClaymore,
        "WEAPON_BOW": weaponBow,
        "WEAPON_POLE": weaponPole,
      };
}

class CharacterInfo {
  final int id;
  final int rank;
  final String name;
  final String element;
  final String weaponType;
  final String icon;
  final List<int> birthday;
  final int release;
  final String route;
  final bool? beta;

  CharacterInfo({
    required this.id,
    required this.rank,
    required this.name,
    required this.element,
    required this.weaponType,
    required this.icon,
    required this.birthday,
    required this.release,
    required this.route,
    this.beta,
  });

  factory CharacterInfo.fromJson(Map<String, dynamic> json) => CharacterInfo(
        id: json["id"] ?? 1,
        rank: json["rank"] ?? 1,
        name: json["name"] ?? "",
        element: json["element"] ?? "",
        weaponType: json["weaponType"] ?? "",
        icon: json["icon"] ?? "",
        birthday: List<int>.from(
          (json["birthday"] as List<int>? ?? []).map((x) => x),
        ),
        release: json["release"] ?? 0,
        route: json["route"] ?? "",
        beta: json["beta"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "name": name,
        "element": element,
        "weaponType": weaponType,
        "icon": icon,
        "birthday": List<dynamic>.from(birthday.map((x) => x)),
        "release": release,
        "route": route,
        "beta": beta,
      };
}
