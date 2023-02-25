import 'package:genshinfan/objects/reward_preview.dart';

List<int> levels = [
  1,
  5,
  10,
  15,
  20,
  25,
  30,
  35,
  40,
  45,
  50,
  55,
  60,
  65,
  70,
  75,
  80,
  85,
  90,
  95,
  100,
  105,
  110,
  115,
];

class Enemy {
  Enemy({
    required this.name,
    required this.specialname,
    required this.enemytype,
    required this.category,
    required this.description,
    required this.investigation,
    required this.rewardpreview,
    this.images,
    this.stats,
  });

  String name;
  String specialname;
  String enemytype;
  String category;
  String description;
  Investigation? investigation;
  List<Rewardpreview> rewardpreview;
  ImageEnemy? images;
  List<Stat>? stats;

  factory Enemy.fromJson(Map<String, dynamic> json) => Enemy(
        name: json["name"],
        specialname: json["specialname"],
        enemytype: json["enemytype"],
        category: json["category"],
        description: json["description"],
        investigation: json["investigation"] == null
            ? null
            : Investigation.fromJson(json["investigation"]),
        rewardpreview: List<Rewardpreview>.from(
            json["rewardpreview"].map((x) => Rewardpreview.fromJson(x))),
        images:
            json['images'] == null ? null : ImageEnemy.fromJson(json['images']),
        stats: json["stats"] == null
            ? null
            : List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "specialname": specialname,
        "enemytype": enemytype,
        "category": category,
        "description": description,
        "investigation": investigation?.toJson(),
        "rewardpreview":
            List<dynamic>.from(rewardpreview.map((x) => x.toJson())),
        "images": images?.toJson(),
        "stats": stats == null
            ? null
            : List<dynamic>.from(stats!.map((x) => x.toJson())),
      };

  void setImage(dynamic json) {
    images = ImageEnemy.fromJson(json);
  }

  /// `stat`: base của quái vật
  /// `curve`: base của tất quái vật
  void setStat(dynamic stat, dynamic curve) {
    List<Stat> listData = [];
    Map<String, dynamic> base = stat['base'];
    Map<String, dynamic> curveBase = stat['curve'];
    for (int i = 0; i < levels.length; i++) {
      // lấy level
      int level = levels[i];
      // xử lý hp
      double hp = base['hp'] * curve["$level"][curveBase['hp']];
      // xử lý attack
      double attack = base['attack'] * curve["$level"][curveBase['attack']];
      // tạo stat
      Stat stat = Stat(
        level: level,
        hp: hp,
        attack: attack,
        defense: level * 5 + 500,
      );
      listData.add(stat);
    }
    stats = listData;
  }
}

class Investigation {
  Investigation({
    required this.name,
    required this.category,
    required this.description,
  });

  String name;
  String category;
  String description;

  factory Investigation.fromJson(Map<String, dynamic> json) => Investigation(
        name: json["name"],
        category: json["category"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "description": description,
      };
}

class ImageEnemy {
  ImageEnemy({
    this.nameicon,
  });

  String? nameicon;

  factory ImageEnemy.fromJson(Map<String, dynamic> json) => ImageEnemy(
        nameicon: json["nameicon"],
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
      };
}

class Stat {
  Stat({
    required this.level,
    required this.hp,
    required this.attack,
    required this.defense,
  });

  int level;
  double hp;
  double attack;
  double defense;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        level: json["level"],
        hp: json["hp"].toDouble(),
        attack: json["attack"].toDouble(),
        defense: json["defense"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "hp": hp,
        "attack": attack,
        "defense": defense,
      };
}
