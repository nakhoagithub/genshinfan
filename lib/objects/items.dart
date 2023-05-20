class Items {
  final int id;
  final String name;
  final int count;
  const Items({
    required this.id,
    required this.name,
    required this.count,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
      };
}
