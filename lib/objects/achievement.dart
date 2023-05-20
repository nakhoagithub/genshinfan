import 'package:genshinfan/objects/reward.dart';

class AchievementGroup {
  String? key;
  final String name;
  final int? sortorder;
  final Reward? reward;
  String? version;
  ImageAchievementGroup? images;

  AchievementGroup({
    this.key,
    required this.name,
    required this.sortorder,
    this.reward,
    this.images,
    this.version,
  });

  factory AchievementGroup.fromJson(Map<String, dynamic> json) =>
      AchievementGroup(
        key: json['key'],
        name: json["name"],
        sortorder: json['sortorder'],
        reward: json['reward'] == null ? null : Reward.fromJson(json['reward']),
        images: json['images'] == null
            ? null
            : ImageAchievementGroup.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "sortorder": sortorder,
        "reward": reward?.toJson(),
        "images": images?.toJson(),
        "version": version,
      };

  void setImage(dynamic json) {
    images = ImageAchievementGroup.fromJson(json);
  }
}

class Achievement {
  String? key;
  final String name;
  final String? dupealias;
  final String achievementgroup;
  final bool? ishidden;
  final int sortorder;
  final int stages;
  final StageAchievement stage1;
  final StageAchievement? stage2;
  final StageAchievement? stage3;
  String? version;

  Achievement({
    this.key,
    required this.name,
    this.dupealias,
    required this.achievementgroup,
    this.ishidden,
    required this.sortorder,
    required this.stages,
    required this.stage1,
    this.stage2,
    this.stage3,
    this.version,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        key: json['key'],
        name: json['name'],
        dupealias: json["dupealias"],
        achievementgroup: json['achievementgroup'],
        ishidden: json['ishidden'],
        sortorder: json['sortorder'],
        stages: json['stages'],
        stage1: StageAchievement.fromJson(json['stage1']),
        stage2: json['stage2'] == null
            ? null
            : StageAchievement.fromJson(json['stage2']),
        stage3: json['stage3'] == null
            ? null
            : StageAchievement.fromJson(json['stage3']),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "dupealias": dupealias,
        "achievementgroup": achievementgroup,
        "ishidden": ishidden,
        "sortorder": sortorder,
        "stages": stages,
        "stage1": stage1.toJson(),
        "stage2": stage2?.toJson(),
        "stage3": stage3?.toJson(),
      };
}

class StageAchievement {
  final String title;
  final String? ps5title;
  final String description;
  final int progress;
  final Reward reward;

  const StageAchievement({
    required this.title,
    this.ps5title,
    required this.description,
    required this.progress,
    required this.reward,
  });

  factory StageAchievement.fromJson(Map<String, dynamic> json) =>
      StageAchievement(
        title: json["title"],
        ps5title: json['ps5title'],
        description: json['description'],
        progress: json['progress'],
        reward: Reward.fromJson(json['reward']),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "ps5title": ps5title,
        "description": description,
        "progress": progress,
        "reward": reward.toJson(),
      };
}

class ImageAchievementGroup {
  final String nameicon;

  const ImageAchievementGroup({
    required this.nameicon,
  });

  factory ImageAchievementGroup.fromJson(Map<String, dynamic> json) =>
      ImageAchievementGroup(
        nameicon: json["nameicon"],
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
      };
}
