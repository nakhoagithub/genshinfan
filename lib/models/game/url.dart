class UrlObject {
  final String fandom;
  const UrlObject({
    required this.fandom,
  });

  factory UrlObject.fromJson(Map<String, dynamic> json) => UrlObject(
        fandom: json["fandom"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fandom": fandom,
      };
}
