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

  String? flower;
  String? plume;
  String? sands;
  String? goblet;
  String circlet;
  String? nameflower;
  String? nameplume;
  String? namesands;
  String? namegoblet;
  String? namecirclet;

  factory ImageArtifact.fromJson(Map<String, dynamic> json) => ImageArtifact(
        flower: json["flower"],
        plume: json["plume"],
        sands: json["sands"],
        goblet: json["goblet"],
        circlet: json["circlet"],
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
