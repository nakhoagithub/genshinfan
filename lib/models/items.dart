class Items {
  final String? name;
  final int? count;
  const Items({
    this.name,
    this.count,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}
