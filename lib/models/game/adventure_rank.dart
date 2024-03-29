class AdventureRank {
  final String name;
  final int exp;
  final String unlockdescription;
  final AdventureRankReward reward;

  const AdventureRank({
    required this.name,
    required this.exp,
    required this.unlockdescription,
    required this.reward,
  });

  factory AdventureRank.fromJson(Map<String, dynamic> json) => AdventureRank(
        name: json['name'] ?? "",
        exp: json["exp"] ?? 0,
        unlockdescription: json['unlockdescription'] ?? "",
        reward: json['reward'] == null
            ? const AdventureRankReward(name: "", count: 0, type: "")
            : AdventureRankReward.fromJson(json['reward']),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "exp": exp,
        "unlockdescription": unlockdescription,
        "reward": reward.toJson(),
      };
}

class AdventureRankReward {
  final String name;
  final int count;
  final String type;

  const AdventureRankReward({
    required this.name,
    required this.count,
    required this.type,
  });

  factory AdventureRankReward.fromJson(Map<String, dynamic> json) =>
      AdventureRankReward(
        name: json['name'] ?? "",
        count: json["count"] ?? 0,
        type: json['type'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "type": type,
      };
}
