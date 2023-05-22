class Geography {
  String? key;
  final String name;
  final String? area;
  final String description;
  final String region;
  final bool? showonlyunlocked;
  final int sortorder;
  ImageGeography? images;
  String? version;

  Geography({
    this.key,
    required this.name,
    required this.area,
    required this.description,
    required this.region,
    this.showonlyunlocked,
    required this.sortorder,
    this.images,
    this.version,
  });

  void setImage(dynamic json) {
    images = ImageGeography.fromJson(json);
  }

  factory Geography.fromJson(Map<String, dynamic> json) => Geography(
        key: json['key'],
        name: json["name"],
        area: json["area"],
        description: json["description"],
        region: json["region"],
        showonlyunlocked: json["showonlyunlocked"],
        sortorder: json["sortorder"],
        images: json['images'] == null
            ? null
            : ImageGeography.fromJson(json['images']),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "area": area,
        "description": description,
        "region": region,
        "showonlyunlocked": showonlyunlocked,
        "sortorder": sortorder,
        "images": images?.toJson(),
        "version": version,
      };
}

class ImageGeography {
  final String nameimage;
  const ImageGeography({
    required this.nameimage,
  });

  factory ImageGeography.fromJson(Map<String, dynamic> json) => ImageGeography(
        nameimage: json["nameimage"],
      );

  Map<String, dynamic> toJson() => {
        "nameimage": nameimage,
      };
}
