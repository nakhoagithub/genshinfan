class Windglider {
  String? key;
  final String name;
  final String description;
  final String rarity;
  final String story;
  final int sortorder;
  final bool? ishidden;
  final List<String> source;
  ImageWindglider? images;
  String? version;

  Windglider({
    required this.name,
    required this.description,
    required this.rarity,
    required this.story,
    required this.sortorder,
    this.ishidden,
    required this.source,
    this.images,
    this.version,
  });

  void setImage(dynamic json) {
    images = ImageWindglider.fromJson(json);
  }

  factory Windglider.fromJson(Map<String, dynamic> json) => Windglider(
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        rarity: json["rarity"] ?? "",
        story: json["story"] ?? "",
        sortorder: json["sortorder"] ?? 0,
        ishidden: json['ishidden'],
        source: json["source"] == null
            ? []
            : List<String>.from(json["source"].map((x) => x)),
        images: json['images'] == null
            ? null
            : ImageWindglider.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "rarity": rarity,
        "story": story,
        "sortorder": sortorder,
        "ishidden": ishidden,
        "source": List<dynamic>.from(source.map((x) => x)),
        "images": images?.toJson(),
        "version": version,
      };
}

class ImageWindglider {
  final String nameicon;
  final String namegacha;

  ImageWindglider({
    required this.nameicon,
    required this.namegacha,
  });

  factory ImageWindglider.fromJson(Map<String, dynamic> json) =>
      ImageWindglider(
        nameicon: json["nameicon"] ?? "",
        namegacha: json["namegacha"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
        "namegacha": namegacha,
      };
}
