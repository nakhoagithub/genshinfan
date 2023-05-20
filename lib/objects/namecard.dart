class Namecard {
  String? key;
  final String name;
  final String description;
  final int sortorder;
  final List<String> source;
  ImageNamecard? images;
  String? version;

  Namecard({
    this.key,
    required this.name,
    required this.description,
    required this.sortorder,
    required this.source,
    this.images,
    this.version,
  });

  void setImage(dynamic json) {
    images = ImageNamecard.fromJson(json);
  }

  factory Namecard.fromJson(Map<String, dynamic> json) => Namecard(
        key: json['key'],
        name: json["name"],
        description: json["description"],
        sortorder: json["sortorder"],
        source: List<String>.from(json["source"].map((x) => x)),
        images: json['images'] == null
            ? null
            : ImageNamecard.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "description": description,
        "sortorder": sortorder,
        "source": List<dynamic>.from(source.map((x) => x)),
        "images": images?.toJson(),
        "version": version,
      };
}

class ImageNamecard {
  final String nameicon;
  final String? namebanner;
  final String namebackground;
  const ImageNamecard({
    required this.nameicon,
    this.namebanner,
    required this.namebackground,
  });

  factory ImageNamecard.fromJson(Map<String, dynamic> json) => ImageNamecard(
        nameicon: json["nameicon"],
        namebanner: json["namebanner"],
        namebackground: json["namebackground"],
      );

  Map<String, dynamic> toJson() => {
        "nameicon": nameicon,
        "namebanner": namebanner,
        "namebackground": namebackground,
      };
}
