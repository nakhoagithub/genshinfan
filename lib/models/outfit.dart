class Outfit {
  String? key;
  final String name;
  final String description;
  final bool isdefault;
  final String character;
  final List<String>? source;
  ImageOutfit? images;
  String? version;

  Outfit({
    this.key,
    required this.name,
    required this.description,
    required this.isdefault,
    required this.character,
    this.source,
    this.images,
    this.version,
  });

  void setImage(dynamic json) {
    images = ImageOutfit.fromJson(json);
  }

  factory Outfit.fromJson(Map<String, dynamic> json) => Outfit(
        key: json['key'],
        name: json["name"],
        description: json["description"],
        isdefault: json["isdefault"],
        character: json["character"],
        source: json['source'] == null
            ? null
            : List<String>.from(json["source"].map((x) => x)),
        images: json['images'] == null
            ? null
            : ImageOutfit.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
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

class ImageOutfit {
  final String namecard;
  final String? nameicon;
  final String? namesideicon;
  final String? namesplash;
  const ImageOutfit({
    required this.namecard,
    this.nameicon,
    this.namesideicon,
    this.namesplash,
  });
  factory ImageOutfit.fromJson(Map<String, dynamic> json) => ImageOutfit(
        namecard: json["namecard"],
        nameicon: json["nameicon"],
        namesideicon: json["namesideicon"],
        namesplash: json["namesplash"],
      );

  Map<String, dynamic> toJson() => {
        "namecard": namecard,
        "nameicon": nameicon,
        "namesideicon": namesideicon,
        "namesplash": namesplash,
      };
}
