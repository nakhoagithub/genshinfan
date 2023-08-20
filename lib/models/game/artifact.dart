class Artifact {
  Artifact({
    this.key,
    required this.name,
    required this.rarity,
    this.set1,
    this.set2,
    this.set4,
    this.flower,
    this.plume,
    this.sands,
    this.goblet,
    required this.circlet,
    this.images,
    this.version,
  });

  String? key;
  final String name;
  final List<String> rarity;
  final String? set1;
  final String? set2;
  final String? set4;
  final ArtifactDetail? flower;
  final ArtifactDetail? plume;
  final ArtifactDetail? sands;
  final ArtifactDetail? goblet;
  final ArtifactDetail circlet;
  ImageArtifact? images;
  String? version;

  factory Artifact.fromJson(Map<String, dynamic> json) => Artifact(
        key: json['key'],
        name: json["name"] ?? "",
        rarity: json["rarity"] == null
            ? []
            : List<String>.from(json["rarity"].map((x) => x)),
        set1: json["1pc"],
        set2: json["2pc"],
        set4: json["4pc"],
        flower: json["flower"] == null
            ? null
            : ArtifactDetail.fromJson(json["flower"]),
        plume: json["plume"] == null
            ? null
            : ArtifactDetail.fromJson(json["plume"]),
        sands: json["sands"] == null
            ? null
            : ArtifactDetail.fromJson(json["sands"]),
        goblet: json["goblet"] == null
            ? null
            : ArtifactDetail.fromJson(json["goblet"]),
        circlet: ArtifactDetail.fromJson(json["circlet"]),
        images: json["images"] == null
            ? null
            : ImageArtifact.fromJson(json["images"]),
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "rarity": List<dynamic>.from(rarity.map((x) => x)),
        "1pc": set1,
        "2pc": set2,
        "4pc": set4,
        "flower": flower?.toJson(),
        "plume": plume?.toJson(),
        "sands": sands?.toJson(),
        "goblet": goblet?.toJson(),
        "circlet": circlet.toJson(),
        "images": images?.toJson(),
        "version": version,
      };

  void setImage(dynamic json) {
    images = ImageArtifact.fromJson(json);
  }
}

class ArtifactDetail {
  ArtifactDetail({
    required this.name,
    required this.relictype,
    required this.description,
    required this.story,
  });

  final String name;
  final String relictype;
  final String description;
  final String story;

  factory ArtifactDetail.fromJson(Map<String, dynamic> json) => ArtifactDetail(
        name: json["name"] ?? "",
        relictype: json["relictype"] ?? "",
        description: json["description"] ?? "",
        story: json['story'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relictype": relictype,
        "description": description,
        "story": story,
      };
}

class ImageArtifact {
  ImageArtifact({
    this.flower,
    this.plume,
    this.sands,
    this.goblet,
    required this.circlet,
    this.nameflower,
    this.nameplume,
    this.namesands,
    this.namegoblet,
    required this.namecirclet,
  });

  final String? flower;
  final String? plume;
  final String? sands;
  final String? goblet;
  final String circlet;
  final String? nameflower;
  final String? nameplume;
  final String? namesands;
  final String? namegoblet;
  final String? namecirclet;

  factory ImageArtifact.fromJson(Map<String, dynamic> json) => ImageArtifact(
        flower: json["flower"],
        plume: json["plume"],
        sands: json["sands"],
        goblet: json["goblet"],
        circlet: json["circlet"] ?? "",
        nameflower: json["nameflower"],
        nameplume: json["nameplume"],
        namesands: json["namesands"],
        namegoblet: json["namegoblet"],
        namecirclet: json["namecirclet"],
      );

  Map<String, dynamic> toJson() => {
        "flower": flower,
        "plume": plume,
        "sands": sands,
        "goblet": goblet,
        "circlet": circlet,
        "nameflower": nameflower,
        "nameplume": nameplume,
        "namesands": namesands,
        "namegoblet": namegoblet,
        "namecirclet": namecirclet,
      };
}
