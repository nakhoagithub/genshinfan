class Outfit {
  final String name;
  final String description;
  final bool isdefault;
  final String character;
  final List<String>? source;
  ImageNamecard? images;
  String? version;

  Outfit({
    required this.name,
    required this.description,
    required this.isdefault,
    required this.character,
    this.source,
    this.images,
    this.version,
  });

  factory Outfit.fromJson(Map<String, dynamic> json) => Outfit(
        name: json["name"],
        description: json["description"],
        isdefault: json["isdefault"],
        character: json["character"],
        source: json['source'] == null
            ? null
            : List<String>.from(json["source"].map((x) => x)),
        images: json['images'] == null
            ? null
            : ImageNamecard.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "isdefault": isdefault,
        "character": character,
        "source":
            source == null ? null : List<dynamic>.from(source!.map((x) => x)),
        "images": images?.toJson(),
        "version": version,
      };
}

class ImageNamecard {
  final String namecard;
  final String? nameicon;
  final String? namesideicon;
  final String namesplash;
  const ImageNamecard({
    required this.namecard,
    required this.nameicon,
    required this.namesideicon,
    required this.namesplash,
  });
  factory ImageNamecard.fromJson(Map<String, dynamic> json) => ImageNamecard(
        namecard: json["namecard"],
        nameicon: json["nameicon"],
        namesideicon: json["namesideicon"],
        namesplash: json["namesplash"],
      );

  Map<String, dynamic> toJson() => {
        "namecard": namecard,
        "nameicon": nameicon,
        "namesideicon": namesideicon,
        "character": namesplash,
      };
}
