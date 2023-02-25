
class Rewardpreview {
  Rewardpreview({
    required this.name,
    this.count,
    this.rarity,
  });

  String name;
  double? count;
  String? rarity;

  factory Rewardpreview.fromJson(Map<String, dynamic> json) => Rewardpreview(
        name: json["name"],
        count: json["count"]?.toDouble(),
        rarity: json["rarity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "rarity": rarity,
      };
}