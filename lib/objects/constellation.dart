class Constellation {
  Constellation({
    required this.name,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    this.images,
    this.version,
  });

  final String name;
  final ConstellationDetail c1;
  final ConstellationDetail c2;
  final ConstellationDetail c3;
  final ConstellationDetail c4;
  final ConstellationDetail c5;
  final ConstellationDetail c6;
  ImageConstellation? images;
  String? version;

  factory Constellation.fromJson(Map<String, dynamic> json) => Constellation(
        name: json["name"],
        c1: ConstellationDetail.fromJson(json["c1"]),
        c2: ConstellationDetail.fromJson(json["c2"]),
        c3: ConstellationDetail.fromJson(json["c3"]),
        c4: ConstellationDetail.fromJson(json["c4"]),
        c5: ConstellationDetail.fromJson(json["c5"]),
        c6: ConstellationDetail.fromJson(json["c6"]),
        images: json["images"] == null
            ? null
            : ImageConstellation.fromJson(json["images"]),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "c1": c1.toJson(),
        "c2": c2.toJson(),
        "c3": c3.toJson(),
        "c4": c4.toJson(),
        "c5": c5.toJson(),
        "c6": c6.toJson(),
        "images": images?.toJson(),
        "version": version,
      };
}

class ConstellationDetail {
  ConstellationDetail({
    required this.name,
    required this.effect,
  });

  final String name;
  final String effect;

  factory ConstellationDetail.fromJson(Map<String, dynamic> json) =>
      ConstellationDetail(
        name: json["name"],
        effect: json["effect"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "effect": effect,
      };
}

class ImageConstellation {
  ImageConstellation({
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    required this.constellation,
    this.constellation2,
  });

  final String c1;
  final String c2;
  final String c3;
  final String c4;
  final String c5;
  final String c6;
  final String constellation;
  final String? constellation2;

  factory ImageConstellation.fromJson(Map<String, dynamic> json) =>
      ImageConstellation(
        c1: json["c1"],
        c2: json["c2"],
        c3: json["c3"],
        c4: json["c4"],
        c5: json["c5"],
        c6: json["c6"],
        constellation: json["constellation"],
        constellation2: json["constellation2"],
      );

  Map<String, dynamic> toJson() => {
        "c1": c1,
        "c2": c2,
        "c3": c3,
        "c4": c4,
        "c5": c5,
        "c6": c6,
        "constellation": constellation,
        "constellation2": constellation2,
      };
}
