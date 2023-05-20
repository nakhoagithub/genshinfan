class Constellation {
  Constellation({
    required this.id,
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

  final int id;
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
        id: json['id'],
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
        "id": id,
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
    required this.description,
    required this.descriptionRaw,
  });

  final String name;
  final String description;
  final String descriptionRaw;

  factory ConstellationDetail.fromJson(Map<String, dynamic> json) =>
      ConstellationDetail(
        name: json["name"],
        description: json["description"],
        descriptionRaw: json['descriptionRaw'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "descriptionRaw": descriptionRaw,
      };
}

class ImageConstellation {
  ImageConstellation({
    required this.filenameC1,
    required this.filenameC2,
    required this.filenameC3,
    required this.filenameC4,
    required this.filenameC5,
    required this.filenameC6,
    required this.filenameConstellation,
    this.filenameConstellation2,
  });

  final String filenameC1;
  final String filenameC2;
  final String filenameC3;
  final String filenameC4;
  final String filenameC5;
  final String filenameC6;
  final String filenameConstellation;
  final String? filenameConstellation2;

  factory ImageConstellation.fromJson(Map<String, dynamic> json) =>
      ImageConstellation(
        filenameC1: json["c1"],
        filenameC2: json["c2"],
        filenameC3: json["c3"],
        filenameC4: json["c4"],
        filenameC5: json["c5"],
        filenameC6: json["c6"],
        filenameConstellation: json["constellation"],
        filenameConstellation2: json["constellation2"],
      );

  Map<String, dynamic> toJson() => {
        "c1": filenameC1,
        "c2": filenameC2,
        "c3": filenameC3,
        "c4": filenameC4,
        "c5": filenameC5,
        "c6": filenameC6,
        "constellation": filenameConstellation,
        "constellation2": filenameConstellation2,
      };
}
