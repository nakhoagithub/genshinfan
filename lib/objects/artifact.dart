import 'image_artifact.dart';

class Artifact {
  Artifact({
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
  });

  String name;
  List<String> rarity;
  String? set1;
  String? set2;
  String? set4;
  ArtifactItem? flower;
  ArtifactItem? plume;
  ArtifactItem? sands;
  ArtifactItem? goblet;
  ArtifactItem circlet;
  ImageArtifact? images;

  factory Artifact.fromJson(Map<String, dynamic> json) => Artifact(
        name: json["name"],
        rarity: List<String>.from(json["rarity"].map((x) => x)),
        set1: json["1pc"],
        set2: json["2pc"],
        set4: json["4pc"],
        flower: json["flower"] == null
            ? null
            : ArtifactItem.fromJson(json["flower"]),
        plume:
            json["plume"] == null ? null : ArtifactItem.fromJson(json["plume"]),
        sands:
            json["sands"] == null ? null : ArtifactItem.fromJson(json["sands"]),
        goblet: json["goblet"] == null
            ? null
            : ArtifactItem.fromJson(json["goblet"]),
        circlet: ArtifactItem.fromJson(json["circlet"]),
        images: json["images"] == null
            ? null
            : ImageArtifact.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
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
      };

  void setImage(dynamic json) {
    images = ImageArtifact.fromJson(json);
  }
}

class ArtifactItem {
  ArtifactItem({
    required this.name,
    required this.relictype,
    required this.description,
  });

  String name;
  String relictype;
  String description;

  factory ArtifactItem.fromJson(Map<String, dynamic> json) => ArtifactItem(
        name: json["name"],
        relictype: json["relictype"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "relictype": relictype,
        "description": description,
      };
}
