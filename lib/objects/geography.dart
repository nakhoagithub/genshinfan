class Geography {
  final String name;
  final String area;
  final String description;
  final String region;
  final bool? showonlyunlocked;
  final int sortorder;
  String? version;

  Geography({
    required this.name,
    required this.area,
    required this.description,
    required this.region,
    this.showonlyunlocked,
    required this.sortorder,
    this.version,
  });

  factory Geography.fromJson(Map<String, dynamic> json) => Geography(
        name: json["name"],
        area: json["area"],
        description: json["description"],
        region: json["region"],
        showonlyunlocked: json["showonlyunlocked"],
        sortorder: json["sortorder"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "area": area,
        "description": description,
        "region": region,
        "showonlyunlocked": showonlyunlocked,
        "sortorder": sortorder,
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
