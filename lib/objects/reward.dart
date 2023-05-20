class Reward {
  final String name;
  final String? rarity;
  final double? count;
  final double? countmax;

  const Reward({
    required this.name,
    this.rarity,
    this.count,
    this.countmax,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        name: json["name"],
        rarity: json['rarity'],
        count: json['count']?.toDouble(),
        countmax: json['countmax']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rarity": rarity,
        "count": count,
        "countmax": countmax,
      };
}
